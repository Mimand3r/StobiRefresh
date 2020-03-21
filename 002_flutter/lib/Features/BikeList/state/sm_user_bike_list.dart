import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';

class SmUserBikeList with ChangeNotifier {
  List<FbaseBike> _userBikes;

  SmUserBikeList() {
    AuthModule.instance.addListener(extractNewBikeList); // Subscribe to Auth Module
    extractNewBikeList();
  } 

  void extractNewBikeList() {
    var user = AuthModule.instance.getLoggedInUser();
    _userBikes = user.bikes;
    notifyListeners();
  }

  List<FbaseBike> getUserBikes() => _userBikes;
}
