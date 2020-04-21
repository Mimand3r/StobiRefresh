import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/config/firebase_configs.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/model_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/transfer_data_bike.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/worker/firestore_user_worker.dart';

class FirestoreBiketransferWorker {
  static Future<M_Bike> getBikeDataFromPin(String pin) async {

    print("Getting Data from Firestore - Global PIN List Entry - $pin");

    var data = await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(pin_list_name)
        .document(pin)
        .get();

    if (!data.exists) return null;

    var transferData = BikeTransferData.fromSnapshot(data);
    var rahmenNr = transferData.rahmenNr;

    return await FirestoreBikeWorker.getSingleBike(rahmenNr);
  }

  static Future writePIN(M_Bike bike) async {

    print("Writing Data to Firestore - New Global PIN List Entry - ${bike.transferData.pin}");

    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(pin_list_name)
        .document(bike.transferData.pin)
        .setData(bike.transferData.toSnapshot());

    await FirestoreBikeWorker.writeSingleBike(bike);
  }

  static Future removePinFromGlobal(String pin) async {

    print("Removing Data from Firestore - Removed Global PIN List Entry - $pin");

    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(pin_list_name)
        .document(pin)
        .delete();
  }

  static Future transferBikeFromUserAToB(
      E_Bike bike, String uID_A, String uID_B) async {

    await removePinFromGlobal(bike.transferData.pin);

    bike.transferData = null;
    bike.currentOwnerId = uID_B;

    await FirestoreBikeWorker.writeSingleBike(bike.toMBike());

    await FirestoreUserWorker.removeBikeReferenceFromUser(
        uID_A, bike.rahmenNummer);

    await FirestoreUserWorker.addBikeReferenceToUser(uID_B, bike.rahmenNummer);
  }
}
