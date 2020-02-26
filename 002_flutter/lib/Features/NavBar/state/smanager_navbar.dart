import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeRegistration/ui/bike_registration_page.dart';

class SmNavbar with ChangeNotifier{
  
  bool showLogo = true;
  bool showPageNavigation = true;
  bool showOptions = true;
  bool showAddElement = false;
  Pages activePage = Pages.none;

  void updateNavBar(){
    notifyListeners();
  }

  void switchToAddBikePage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (c)=>BikeRegistrationPage()));
  }
}

enum Pages{
  none,
  myBikes,
  search,
  chats
}