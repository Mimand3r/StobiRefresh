import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/ui/page_mybikes.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/register_bike_popup.dart';
import 'package:project_stobi/Features/BikeSearch/ui/bikesearch_result_popup.dart';
import 'package:project_stobi/Features/BikeSearch/ui/page_searching.dart';
import 'package:project_stobi/Features/Chat/ui/chat_popup.dart';
import 'package:project_stobi/Features/Chat/ui/page_conversations.dart';
import 'package:project_stobi/Features/MainPage/ui/widgets/background.dart';
import 'package:project_stobi/Features/NavBar/ui/nav_bar.dart';
import 'package:project_stobi/Features/NavBar/ui/settings_dropdown.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/messaging_module.dart';
import 'package:project_stobi/TechnischeFeatures/Navigation/navigation_helper.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, @required this.osData, @required this.user})
      : super(key: key);

  final DbUser user;
  final MediaQueryData osData;

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // State Params

  bool currentlyRegisteringABike = false;
  bool currentlyGettingBikeList = false;
  bool currentlyLoadingConversations = false;
  bool currentlySearchingABike = false;

  DbUser user;
  List<Bike> bikeList;
  List<Conversation> conversationList;

  bool hasActiveChats = false;
  int unreadMessages = 0;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    calculateNavbarPageRatio();
    loadUserBikeList();
    loadUserConversationList();
    MessagingModule.instance.init(user.uId, messageArrived);
  }

  double topAreaHeight;
  double pageAreaHeight;

  void calculateNavbarPageRatio() {
    var realAvailableHeight =
        widget.osData.size.height - widget.osData.padding.top;
    topAreaHeight =
        (realAvailableHeight / pow(1.618, 4)) + widget.osData.padding.top;
    pageAreaHeight = widget.osData.size.height - topAreaHeight;
  }

  Future loadUserBikeList() async {
    setState(() {
      currentlyGettingBikeList = true;
    });
    var newBikeList = await FirestoreModule.instance.getUserBikeList(user);
    setState(() {
      bikeList = newBikeList;
      currentlyGettingBikeList = false;
    });
  }

  Future loadUserConversationList() async {
    setState(() => currentlyLoadingConversations = true);
    var newConvList =
        await FirestoreModule.instance.getAllUserConversations(user);

    var newUnreadMessages = 0;
    user.unreadMessages.forEach((s, i) => newUnreadMessages += i);

    setState(() {
      conversationList = newConvList;
      currentlyLoadingConversations = false;
      hasActiveChats = conversationList.length != 0;
      unreadMessages = newUnreadMessages;
    });
  }

  // Callbacks
  void userWantsPageSwitch(int newPage) {
    setState(() {
      activePage = newPage;
    });
  }

  Future userSuchtFahrrad(BuildContext context, String gestellNr) async {
    setState(() {
      currentlySearchingABike = true;
    });
    var newBike = await FirestoreModule.instance.searchABike(gestellNr);

    setState(() {
      currentlySearchingABike = false;
    });

    if (newBike == null)
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Es wurde kein Fahrrad gefunden"),
        duration: Duration(seconds: 4),
      ));
    else {
      NavigationHelper.navigateTo(
          context,
          BikesearchResultPopup(
            bike: newBike,
            user: user,
            kontaktiereUserCallback: (b) async {
              await userWillBesitzerKontaktieren(context, b);
            },
          ));
    }
  }

  Future userRegisteredNewBike(BuildContext context, String gestellNr,
      String modellBezeichnung, String spitzName) async {
    try {
      setState(() {
        currentlyRegisteringABike = true;
      });
      await FirestoreModule.instance
          .registerABike(user, gestellNr, modellBezeichnung, spitzName, "");
    } on Exception catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Unter der Gestellnummer gibt es bereits einen Eintrag"),
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      currentlyRegisteringABike = false;
      loadUserBikeList();
    });
  }

  void elementChosenInSettingsPopup(PopupPages elementId) {
    if (elementId == PopupPages.RegisterBikePage) {
      NavigationHelper.navigateTo(
          context,
          RegisterBikePopup(
              width: widget.osData.size.width,
              userRegisteredBikeCallback: (s, t, u) async {
                await userRegisteredNewBike(context, s, t, u);
              }));
    }
  }

  Future userWillBesitzerKontaktieren(BuildContext context, Bike bike) async {
    setState(() {
      hasActiveChats = true;
      activePage = 2;
      currentlyLoadingConversations = true;
    });
    var neueConversation = await FirestoreModule.instance
        .erstelleNeueKonversationMitFahrradBesitzer(user, bike);
    var newUser = await FirestoreWorker.readUserFromDb(user.uId);
    setState(() {
      user = newUser;
    });
    await loadUserConversationList();
    var partnerId = (neueConversation.adressant != user.uId)
        ? neueConversation.adressant
        : neueConversation.ersteller;

    chatTapped(neueConversation, partnerId);
  }

  Future messageArrived() async {
    var newUser = await FirestoreWorker.readUserFromDb(user.uId);
    setState(() {
      user = newUser;
    });
    await loadUserConversationList();
  }

  void chatTapped(Conversation conv, String partnerId) {
    FirestoreModule.instance
        .chatRoomBetreten(conv.convId, user)
        .then((_) async {
      var newUser = await FirestoreWorker.readUserFromDb(user.uId);
      setState(() {
        user = newUser;
      });
      await loadUserConversationList();
    });
    NavigationHelper.navigateTo(
        context,
        ChatPopup(
          height: widget.osData.size.height,
          width: widget.osData.size.width,
          conversationData: conv,
          user: widget.user,
          chatPartnerId: partnerId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Background(),
        Column(
          children: <Widget>[
            NavigationBar(
              height: topAreaHeight,
              width: widget.osData.size.width,
              topPadding: widget.osData.padding.top,
              currentActivePage: activePage,
              settingsDropdownReference: SettingsDropdown(
                activePage: activePage,
                elementChosenCallback: elementChosenInSettingsPopup,
              ),
              userWantsPageSwitchCallback: userWantsPageSwitch,
              hasActiveChats: hasActiveChats,
              unreadMessages: unreadMessages,
            ),
            StatefulBuilder(
              builder: (context, f) {
                switch (activePage) {
                  case 0:
                    return SearchingPage(
                        height: pageAreaHeight,
                        width: widget.osData.size.width,
                        userWillFahrradSuchenCallback: (s) {
                          userSuchtFahrrad(context, s);
                        },
                        currentlySearchingABike: currentlySearchingABike);
                  case 1:
                    return MyBikesPage(
                        height: pageAreaHeight,
                        width: widget.osData.size.width,
                        user: user,
                        currentlyRegisteringABike: currentlyRegisteringABike,
                        currentlyGettingBikeList: currentlyGettingBikeList,
                        bikeList: bikeList);
                  case 2:
                    return ConversationsPage(
                      width: widget.osData.size.width,
                      height: widget.osData.size.height,
                      conversationList: conversationList,
                      currentlyLoadingConversations:
                          currentlyLoadingConversations,
                      user: user,
                      chatTappedCallback: chatTapped,
                    );
                }
                return Center(
                  child: Text("Error"),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}

enum PopupPages { UserPage, RegisterBikePage, ChatPage }
