import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/model_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/transfer_data_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_transfer_worker.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_worker.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_user_worker.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/storage_picture_worker.dart';

class E_Bike {
  String rahmenNummer;
  BikeIdData idData;
  BikeVersicherungsData versicherungsData;
  List<String> pictures;
  String currentOwnerId;
  BikeTransferData transferData;
  bool registeredAsStolen = false;

  E_Bike({
    this.rahmenNummer,
    this.idData,
    this.versicherungsData,
    this.currentOwnerId,
    this.transferData,
    this.registeredAsStolen,
  });

  static E_Bike fromMBike(M_Bike mBike) => E_Bike(
        rahmenNummer: mBike.rahmenNummer,
        idData: mBike.idData,
        versicherungsData: mBike.versicherungsData,
        currentOwnerId: mBike.currentOwner,
        transferData: mBike.transferData,
        registeredAsStolen: mBike.registeredAsStolen,
      )..pictures = mBike.pictures;

  M_Bike toMBike() => M_Bike(
        rahmenNummer: this.rahmenNummer,
        idData: this.idData,
        versicherungsData: this.versicherungsData,
        currentOwner: this.currentOwnerId,
        transferData: this.transferData,
        registeredAsStolen: this.registeredAsStolen,
      )..pictures = this.pictures;

  E_User _ownerData = null;

  Future<E_User> get fullOwnerData async {
    if (_ownerData != null) return _ownerData;

    var m_owner = await FirestoreUserWorker.getUserData(this.currentOwnerId);
    _ownerData = await E_User.fromMUser(m_owner);
    return _ownerData;
  }

  Future<void> generateNewPIN({String purpose = "nicht definiert"}) async {
    if (transferData != null) return;
    await BikeTransferData.generateNewPin(purpose, currentOwnerId, this);
  }

  Future<void> removeBikePIN() async {
    await FirestoreBiketransferWorker.removePinFromGlobal(
        this.transferData.pin);
    this.transferData = null;
    FirestoreBikeWorker.writeSingleBike(this.toMBike());
  }

  Future<void> transferToNewUser(String newUserUid) async {
    await FirestoreBiketransferWorker.transferBikeFromUserAToB(
        this, this.currentOwnerId, newUserUid);
    this.currentOwnerId = newUserUid;
  }

  Future<List<Image>> downloadAllBikePictures() async {
    var pictures = <Image>[];

    if (this.pictures == null || this.pictures.length == 0)
      return <Image>[
        Image.asset("assets/pictures/NoPictures.png", height: 100, width: 100)
      ];

    for (var picName in this.pictures) {
      var file = await StoragePictureWorker.downloadPictureFromStorage(picName);

      if (file == null) pictures.add(Image.file(file));
    }

    return pictures;
  }
}
