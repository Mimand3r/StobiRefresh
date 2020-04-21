import 'package:flutter/material.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';

class SmUserBikeList with ChangeNotifier {
  List<E_Bike> _userBikes = new List<E_Bike>();
  Map<String, List<Image>> _pictures = Map<String, List<Image>>();

  SmUserBikeList() : super() {
    instance = this;
  }

  static SmUserBikeList instance = null;



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
