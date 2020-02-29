import 'package:cloud_firestore/cloud_firestore.dart';

import 'data/fbaseUser.dart';

class FireStoreWorker {
  static Future<void> writeUserToDb(FbaseUser user) async =>
      await Firestore.instance
          .collection("registered_users")
          .document(user.uId)
          .setData(user.toSnapshot());

  static Future<FbaseUser> readUserFromDb(String uId) async {
    var snap = await Firestore.instance
        .collection("registered_users")
        .document(uId)
        .get();

    if (snap.data == null) return null;

    return FbaseUser.fromSnapshot(snap);
  }
}
