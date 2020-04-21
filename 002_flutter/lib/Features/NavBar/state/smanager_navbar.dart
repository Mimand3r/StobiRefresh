import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:STOBI/Features/BikeList/ui/page_mybikes.dart';
import 'package:STOBI/Features/BikeRegistration/ui/bike_registration_page.dart';
import 'package:STOBI/Features/BikeSearch/ui/page_bike_search.dart';
import 'package:STOBI/Features/BikeTransfer/ui/bike_export_page.dart';
import 'package:STOBI/Features/Chat/ui/chat_page.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:provider/provider.dart';

class SmNavbar with ChangeNotifier {
  void switchToPage(BuildContext context, Pages page) {
    switch (page) {
      case Pages.home:
        Navigator.popUntil(context, (r) => r.isFirst);
        break;
      case Pages.myBikes:
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (c) => PageMyBikes()), (r) => r.isFirst);
        break;
      case Pages.search:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => BikeSearchPage()),
            (r) => r.isFirst);
        break;
      case Pages.chats:
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (c) => ChatPage()), (r) => r.isFirst);
        break;
      case Pages.addBike:
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => BikeRegistrationPage()));
        break;
      default:
    }
  }

  E_Bike selectedBike;

  void switchToExportBikePage(BuildContext context) {
    var bikeList = Provider.of<SmUserBikeList>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => BikeExportPage(
              bike: selectedBike,
              firstPicture: bikeList.getPicturesForSpecificOwnedBike(selectedBike.rahmenNummer)[0],
            )));
  }

  // For TemporalBotBarHiding
  bool hiddenBottomBar = false;

  void changeBottomBarVisibility(bool hidden) {
    hiddenBottomBar = hidden;
    notifyListeners();
  }
}

enum Pages { home, myBikes, search, chats, addBike }
