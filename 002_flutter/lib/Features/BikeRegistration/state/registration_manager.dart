
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/fbaseUser.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';

class SmRegistrationManager with ChangeNotifier {


  Future registerBike(Bike bikeData, List<File> pictureData) async {

    // Upload Each Picture to Storage and store urls
    var urlList = <String>[];

    for (var i = 0; i < pictureData.length; i++) {
       var url = await FireStoreWorker.storePictureFileInStorage(pictureData[i]);
      urlList.add(url);
    }
    
    // Put url List into Bikedata
    bikeData.pictures = urlList;

    // Put BikeData into UserList and invoke rewrite
    var oldUserData = AuthModule.instance.getLoggedInUser();
    oldUserData.bikes.add(bikeData);
    await AuthModule.instance.changeUserData(oldUserData);
    
  }


}