import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project_stobi/Features/Login/state/auth_module.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types_depricated.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_user.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';
import 'package:provider/provider.dart';

class SmTransfer with ChangeNotifier {
  Future createNewBikePIN(
      FbaseBike bike, String emfaengerName) async {
    var userData = AuthModule.instance.getLoggedInUser();

    var newPin = await BikeTransferData.generateNewPin(
        emfaengerName, userData.name, bike.rahmenNummer, userData.uId);

    await FireStoreWorker.storeNewPinDataForBike(bike, userData, newPin);
  }

  Future deleteBikePIN(FbaseBike bike) async {
    await FireStoreWorker.removeBikePinData(bike);
  }

  Future<FbaseBike> checkIfPinIsValid(String pin) async {

  }

  Future<bool> transferBikeFromUserAToB(FbaseBike bike, String aUId, String bUId){
    
  }

  // Future<PINEinloeseResult> loesePINEin() async{

  // }
}

