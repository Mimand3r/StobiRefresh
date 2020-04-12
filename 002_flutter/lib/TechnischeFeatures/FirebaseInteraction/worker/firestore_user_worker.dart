import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/config/firebase_configs.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/model_user.dart';

class FirestoreUserWorker {
  static Future<void> writeUserToDb(M_User user) async {
    print("Writing Data to Firestore - Writing UserData - ${user.uId}");
    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(user_list_name)
        .document(user.uId)
        .setData(user.toSnapshot());
  }

  static Future<M_User> getUserData(String uId) async {
    print("Reading Data from Firestore - Reading UserData - $uId");
    var snap = await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(user_list_name)
        .document(uId)
        .get();

    if (snap.data == null) return null;

    return M_User.fromSnapshot(snap);
  }

  static Future<void> addBikeReferenceToUser(
      String uId, String rahmenNr) async {
    print(
        "Writing Data to Firestore - Added BikeElement to User - uID: $uId - bikeNr: $rahmenNr");

    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(user_list_name)
        .document(uId)
        .updateData({
      "bikes": FieldValue.arrayUnion(<String>[rahmenNr])
    });
  }

  static Future<void> removeBikeReferenceFromUser(
      String uId, String rahmenNr) async {
    print(
        "Deleting Data from Firestore - Removed BikeElement from User - uID: $uId - bikeNr: $rahmenNr");

    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(user_list_name)
        .document(uId)
        .updateData({
      "bikes": FieldValue.arrayRemove(<String>[rahmenNr])
    });
  }
}
