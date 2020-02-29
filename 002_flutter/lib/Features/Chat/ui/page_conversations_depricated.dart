import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/ui/widgets/loading_widget.dart';
import 'package:project_stobi/General/colors.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types_depricated.dart';

class ConversationsPageDepricated extends StatefulWidget {
  final List<Conversation> conversationList;
  final bool currentlyLoadingConversations;
  final DbUser_depricated user;
  final double width;
  final double height;
  final void Function(Conversation, String) chatTappedCallback;

  const ConversationsPageDepricated(
      {Key key,
      @required this.conversationList,
      @required this.currentlyLoadingConversations,
      @required this.user,
      @required this.width,
      @required this.height, @required this.chatTappedCallback})
      : super(key: key);

  @override
  _ConversationsPageDepricatedState createState() => _ConversationsPageDepricatedState();
}

class _ConversationsPageDepricatedState extends State<ConversationsPageDepricated> {
  final ScrollController listScrollController = new ScrollController();

  void chatGotTapped(BuildContext context, int i, String chatPartnerId) {
    widget.chatTappedCallback(widget.conversationList[i], chatPartnerId);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentlyLoadingConversations)
      return LoadingWidget(
        loadingText: "Chats werden geladen",
      );

    return Center(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        controller: listScrollController,
        shrinkWrap: true, // Weird: is needed
        itemCount: widget.conversationList.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              var conv = widget.conversationList[i];
              var otherUid = (conv.ersteller != widget.user.uId)
                  ? conv.ersteller
                  : conv.adressant;
              chatGotTapped(context, i, otherUid);
            },
            child: Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background_gradient_start,
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/pictures/anonymousBike.jpg'))),
                  ),

                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, f) {
                            var conv = widget.conversationList[i];
                            if (conv.ersteller != widget.user.uId)
                              return Text(
                                  "Chat mit Finder von ${conv.fahrradModell} - ${conv.fahrradGestellNr}");
                            else
                              return Text(
                                  "Chat mit Besitzer von ${conv.fahrradModell} - ${conv.fahrradGestellNr}");
                          },
                        ),
                      ),
                       StatefulBuilder(
                        builder: (c,f){
                          var conv = widget.conversationList[i];
                          var convId = conv.convId;
                          if (widget.user.unreadMessages.containsKey(convId))
                           return Container(
                             padding: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: FittedBox(
                                        child: Text(
                                          "${widget.user.unreadMessages[convId]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors
                                                  .top_bar_gradient_start),
                                        ),
                                      ),
                                    );
                          return Container();
                        },
                      ),
                    ],
                  ),
                  trailing:                    
                      Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
