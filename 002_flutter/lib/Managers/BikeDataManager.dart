import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/storage_picture_worker.dart';

class BikeDataManager {
  // Singleton
  BikeDataManager._privateConstructor();
  static final BikeDataManager instance = BikeDataManager._privateConstructor();

  List<E_Bike> _user_bikes = new List<E_Bike>();
  Map<String, List<Image>> _pictures = Map<String, List<Image>>();

  List<dynamic> getCurrentLists() {
    var li = new List<dynamic>();
    li.add(_user_bikes);
    li.add(_pictures);
    return li;
  }

  void storeBikesWithKnownPicturesInGlobalList(
      List<E_Bike> newBikes, Map<String, List<Image>> newPictures) async {
    // Update own State
    for (var newBike in newBikes) {
      _user_bikes.add(newBike);
      _pictures[newBike.rahmenNummer] = newPictures[newBike.rahmenNummer];
    }

    // Notifiy SmUserBikeList
    SmUserBikeList.instance?.updateYourData(_user_bikes, _pictures);
  }

  Future storeBikesWithUnknownPicturesInGlobalList(
      List<E_Bike> newBikes) async {
    var downloadedPics = new Map<String, List<Image>>();

    // Download Bike Pictures
    for (var newBike in newBikes) {   
      var pictures = await newBike.downloadAllBikePictures();     
      downloadedPics[newBike.rahmenNummer] = pictures;
    }

    storeBikesWithKnownPicturesInGlobalList(newBikes, downloadedPics);
  }

  Future storeBikesWithUnknownPicturesInGlobalList_FromString(
      List<String> rahmenNummern) async {

        var mBikes = await FirestoreBikeWorker.getMultipleBikes(rahmenNummern);
        var eBikes = mBikes.map((x)=>E_Bike.fromMBike(x)).toList();

        await storeBikesWithUnknownPicturesInGlobalList(eBikes);
  }

  void removeBikeFromGlobalList(String rahmenNr) {
    _user_bikes.firstWhere((x) => x.rahmenNummer == rahmenNr);
    _pictures.remove(rahmenNr);

    // Notifiy SmUserBikeList
    SmUserBikeList.instance.updateYourData(_user_bikes, _pictures);
  }
  
}
