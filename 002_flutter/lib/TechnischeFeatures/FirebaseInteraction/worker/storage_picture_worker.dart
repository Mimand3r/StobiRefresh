import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:STOBI/Managers/UserManager.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/config/firebase_configs.dart';

class StoragePictureWorker {
  static Future<String> storePictureFileInStorage(File picture) async {
    
    var uId = UserManager.instance.getCurrentUser.uId;
    var time = Timestamp.now().millisecondsSinceEpoch;
    var fileEnding = picture.path.split(".").last;
    var pictureName = "${uId}_$time.$fileEnding";

    var storageReference =
        FirebaseStorage.instance.ref().child('$picture_folder/$pictureName');

    print("Writing Data to Storage - New Picture $pictureName");
    var uploadTask = storageReference.putFile(picture);

    var taskResult = await uploadTask.onComplete;

    if (taskResult.error != null) {
      print("UPLOAD ERROR - Writing Data to Storage - New Picture $pictureName");
      return null;
    }

    return pictureName;
  }

  static Future<File> downloadPictureFromStorage(String picName) async {
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$picName');

    final StorageReference ref =
        FirebaseStorage.instance.ref().child('$picture_folder/$picName');

    print("Download Data from Storage - Picture $picName");
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    final int byteNumber = (await downloadTask.future).totalByteCount;

    if (byteNumber == 0){
       print("DOWNLOADERROR - Download Data from Storage - Picture $picName");
       return null;
    }

    return file;
  }
}
