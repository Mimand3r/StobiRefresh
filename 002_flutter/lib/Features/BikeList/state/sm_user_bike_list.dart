import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_stobi/Managers/BikeDataManager.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';

class SmUserBikeList with ChangeNotifier {
  List<E_Bike> _userBikes = new List<E_Bike>();
  Map<String, List<Image>> _pictures = Map<String, List<Image>>();

  SmUserBikeList() : super() {
    instance = this;

    // _fetchInitialData();
    print(_userBikes.length);
    print(_pictures.length);
    // var currentLists;
    // scheduleMicrotask(() {
    //   print("fetching data");

    //   instance.notifyListeners();
    // });
  }

  static SmUserBikeList instance = null;

  Future _fetchInitialData() async {
    await Future.microtask(() {
      var currentLists = BikeDataManager.instance.getCurrentLists();
      _userBikes = currentLists[0] as List<E_Bike>;
      _pictures = currentLists[1] as Map<String, List<Image>>;
    });
    print(_userBikes.length);
    print(_pictures.length);
    notifyListeners();
  }

  // invoked by GlobalManager
  void updateYourData(
      List<E_Bike> userBikes, Map<String, List<Image>> pictures) {
    instance._userBikes = userBikes;
    instance._pictures = pictures;
    instance.notifyListeners();
  }

  List<E_Bike> get getUserBikes => _userBikes;

  Map<String, List<Image>> get getAllOwnedBikesPictures => _pictures;

  List<Image> getPicturesForSpecificOwnedBike(String rahmenNummer) {
    // if (!_pictures.containsKey(rahmenNummer))
    //   return ;
    return _pictures[rahmenNummer];
  }
}
