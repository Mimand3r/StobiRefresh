import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';

import 'data/datatype_user.dart';

var dbName = "development";
var dbVersion = "002";
var user_list_name = "users";
var bike_list_name = "bikes";
var picture_folder = "BikePictures";

class FireStoreWorker {
  static Future<void> writeUserToDb(FbaseUser user) async {
    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(user_list_name)
        .document(user.uId)
        .setData(user.toSnapshot());

    await writeBikeDataToGlobalBikeList(user.bikes);
  }

  static Future<FbaseUser> readUserFromDb(String uId) async {
    var snap = await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(user_list_name)
        .document(uId)
        .get();

    if (snap.data == null) return null;

    return FbaseUser.fromSnapshot(snap);
  }

  static Future<void> writeBikeDataToGlobalBikeList(
      List<FbaseBike> bikes) async {
    if (bikes == null) return null;

    for (var bike in bikes)
      await Firestore.instance
          .collection(dbName)
          .document(dbVersion)
          .collection(bike_list_name)
          .document(bike.rahmenNummer)
          .setData(bike.toSnapshot());
  }

  static Future<String> storePictureFileInStorage(File picture) async {
    var uId = AuthModule.instance.getLoggedInUser().uId;
    var time = Timestamp.now().millisecondsSinceEpoch;
    var fileEnding = picture.path.split(".").last;
    var pictureName = "${uId}_$time.$fileEnding";

    var storageReference =
        FirebaseStorage.instance.ref().child('$picture_folder/$pictureName');

    var uploadTask = storageReference.putFile(picture);

    var taskResult = await uploadTask.onComplete;

    if (taskResult.error == true) return null;

    return pictureName;
  }

  static Future<File> downloadPictureFromStorage(String picName) async {
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$picName');

    final StorageReference ref =
        FirebaseStorage.instance.ref().child('$picture_folder/$picName');
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    final int byteNumber = (await downloadTask.future).totalByteCount;

    return file;
  }

  static Future storeNewPinDataForBike(
      FbaseBike bike, FbaseUser user, BikeTransferData newData) async {
    // Store To Local User Bike
    var bikeIndex =
        user.bikes.indexWhere((x) => x.rahmenNummer == bike.rahmenNummer);
    user.bikes[bikeIndex].transferData = newData;

    await writeUserToDb(user); // also Stores in Global Bike List

    // Store to Pin List
    await Firestore.instance
          .collection(dbName)
          .document(dbVersion)
          .collection(pin_list_name)
          .document(newData.pin)
          .setData(newData.toSnapshot());
  }

  static Future<FbaseBike> checkIfPinIsAlreadyTaken(String pin) async {
    var data = await Firestore.instance
          .collection(dbName)
          .document(dbVersion)
          .collection(pin_list_name)
          .document(pin).get();

    

    return data.exists;
  }


  static Future removeBikePinData(FbaseBike bike) async {

    var user = await readUserFromDb(bike.currentOwner);

    // Remove in UserList
    user.bikes.firstWhere((x) => x.rahmenNummer == bike.rahmenNummer).transferData = null;
    await writeUserToDb(user);

    // Remove in Global Bike List
    var oldPin= bike.transferData.pin;
    bike.transferData = null;
    await writeBikeDataToGlobalBikeList(<FbaseBike>[bike]);

    // Remove Pin List Entry
    await Firestore.instance
              .collection(dbName)
              .document(dbVersion)
              .collection(pin_list_name)
              .document(oldPin).delete();

  }

  static Future transferBikeFromUserAToB(FbaseBike bike, String uID_A, String uID_B) async { 

    await removeBikePinData(bike);

    bike.currentOwner = uID_B;

    var userA = await readUserFromDb(uID_A);
    var userB = await readUserFromDb(uID_B);
    
    userA.bikes.removeAt(userA.bikes.indexWhere((x)=> x.rahmenNummer == bike.rahmenNummer));
    userB.bikes.add(bike);

    await writeUserToDb(userA);
    await writeUserToDb(userB);

    await writeBikeDataToGlobalBikeList(<FbaseBike>[bike]);

  }

}
