import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:STOBI/Managers/BikeDataManager.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/model_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_transfer_worker.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_user_worker.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/storage_picture_worker.dart';

class UserManager {
  // Singleton
  UserManager._privateConstructor();
  static final UserManager instance = UserManager._privateConstructor();

  E_User _currentUser;

  E_User get getCurrentUser => _currentUser;

  Future<String> checkIfPreviousUserExists() async {
    var prevUser = await FirebaseAuth.instance.currentUser();
    if (prevUser == null) return "";
    return prevUser.displayName;
  }

  Future<E_User> getPreviousUserData() async {
    var exists = await checkIfPreviousUserExists() != "";
    if (!exists) throw Exception("There is no previous User Data to download");

    var prevUser = await FirebaseAuth.instance.currentUser();
    var userData = await FirestoreUserWorker.getUserData(prevUser.uid);

    if (userData == null) return null;

    var user = E_User.fromMUser(userData);

    _currentUser = user;

    await BikeDataManager.instance
        .storeBikesWithUnknownPicturesInGlobalList_FromString(
            _currentUser.ownedBikesNummernListe);

    return _currentUser;
  }

  Future<E_User> createNewUser(String name) async {
    // Using Anonymous Auth for uID creation
    await FirebaseAuth.instance.signOut();
    var authResult = await FirebaseAuth.instance.signInAnonymously();
    var authUser = authResult.user;

    var userData = UserUpdateInfo();
    userData.displayName = name;
    userData.photoUrl = "defaultPhotoUrl"; // TODO User pics
    try {
      authUser.updateProfile(userData);
    } on Exception {}

    var dummyBikes = _createNewUserDummyBikeList(authUser.uid);

    var newUser = E_User(
        ownedBikesNummernListe:
            dummyBikes.map((el) => el.rahmenNummer).toList(),
        name: name,
        uId: authUser.uid,
        photoUrl: null,
        pushToken: null // TODO pushToken for new User
        );

    try {
      await FirestoreUserWorker.writeUserToDb(newUser.convertToMUser());
      await FirestoreBikeWorker.writeMultipleBikes(
          dummyBikes.map((b) => b.toMBike()).toList());
    } on Exception {
      _currentUser = null;
      return null;
    }

    _currentUser = newUser;

    return _currentUser;
  }

  Future registerNewBikeForUser(E_Bike newBike, List<File> images) async {
    // Upload Each Picture to Storage and store urls
    var urlList = <String>[];

    for (var image in images)
      urlList.add(await StoragePictureWorker.storePictureFileInStorage(image));

    // Put url List into Bikedata
    newBike.pictures = urlList;

    // Mache User Referenz
    _currentUser.ownedBikesNummernListe.add(newBike.rahmenNummer);

    // Write Bike Data
    await FirestoreBikeWorker.writeSingleBike(newBike.toMBike());

    // Write new User Entry
    await FirestoreUserWorker.addBikeReferenceToUser(
        _currentUser.uId, newBike.rahmenNummer);

    // Tell Global Bike Data Manager
    var imageList =
        images.map<Image>((el) => Image.file(el, fit: BoxFit.contain)).toList();

    // Handle No Picture Case
    if (imageList.length == 0)
      imageList.add(Image.asset("assets/pictures/NoPictures.png", height: 100, width: 100));

    BikeDataManager.instance.storeBikesWithKnownPicturesInGlobalList(
        <E_Bike>[newBike], {newBike.rahmenNummer: imageList});
  }

  Future transferBikeFromPreviousUserToCurrent(
      E_Bike bike, List<Image> pictures) async {
    await FirestoreBiketransferWorker.transferBikeFromUserAToB(
        bike, bike.currentOwnerId, _currentUser.uId);

    _currentUser.ownedBikesNummernListe.add(bike.rahmenNummer);
    BikeDataManager.instance.storeBikesWithKnownPicturesInGlobalList(
        <E_Bike>[bike], {bike.rahmenNummer: pictures});
  }

  List<E_Bike> _createNewUserDummyBikeList(String uId) {
    var newUserBikeList = new List<E_Bike>();

    for (var i = 1; i <= 9; i++) {
      var dummyBike = new E_Bike(currentOwnerId: uId, registeredAsStolen: false)
        ..rahmenNummer = uId + i.toString();
      if (i != 9) dummyBike.pictures = <String>["bike00${i.toString()}.jpg"];
      dummyBike.idData = new BikeIdData(
          name: "Beispiel Fahrrad " + i.toString(),
          art: "Mountainbike",
          farbe: "Blau",
          groesse: "176cm",
          hersteller: "Triban",
          modell: "RC 100",
          registerDate: 0,
          beschreibung:
              "Ein hypotethisches Beispiel-Fahrrad. Existiert nicht real");
      dummyBike.versicherungsData =
          BikeVersicherungsData(nummer: "111", gesellschaft: "AOV");

      newUserBikeList.add(dummyBike);
    }

    return newUserBikeList;
  }
}
