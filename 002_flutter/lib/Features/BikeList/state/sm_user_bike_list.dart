import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/fbaseUser.dart';

class SmUserBikeList with ChangeNotifier {
  List<Bike> _userBikes;

  SmUserBikeList() {
    AuthModule.instance.addListener(extractNewBikeList); // Subscribe to Auth Module
    extractNewBikeList();
  } 

  void extractNewBikeList() {
    var user = AuthModule.instance.getLoggedInUser();
    _userBikes = user.bikes;
    notifyListeners();
  }

  List<Bike> getUserBikes() => _userBikes;
}
