import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';

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

  static Future<String> storePictureFileInStorage(File picture) async {
    var uId = AuthModule.instance.getLoggedInUser().uId;
    var time = Timestamp.now().millisecondsSinceEpoch;
    var fileEnding = picture.path.split(".").last;
    var pictureName = "${uId}_$time.$fileEnding";

    var storageReference =
        FirebaseStorage.instance.ref().child('BikePictures/$pictureName');

    var uploadTask = storageReference.putFile(picture);

    var taskResult = await uploadTask.onComplete;

    if (taskResult.error == true) return null;

    return pictureName;
  }

  static Future<File> downloadPictureFromStorage(String picName) async {
    
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$picName');

    final StorageReference ref = FirebaseStorage.instance.ref().child('BikePictures/$picName');
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    final int byteNumber = (await downloadTask.future).totalByteCount;
    
    return file;
  }
}
