import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/ui/page_mybikes.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/bike_registration_page.dart';
import 'package:project_stobi/Features/BikeSearch/ui/page_bike_search.dart';
import 'package:project_stobi/Features/BikeTransfer/ui/bike_export_page.dart';
import 'package:project_stobi/Features/Chat/ui/chat_page.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';

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

  FbaseBike selectedBike;
  Image selectedBikePicture;

  void switchToExportBikePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => BikeExportPage(
              bike: selectedBike,
              firstPicture: selectedBikePicture,
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
