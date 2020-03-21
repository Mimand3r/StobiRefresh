import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';

class FbaseBike {
  String rahmenNummer;
  BikeIdData idData;
  BikeVersicherungsData versicherungsData;
  List<String> pictures;
  String currentOwner;
  BikeTransferData transferData;

  FbaseBike(
      {this.rahmenNummer,
      this.idData,
      this.versicherungsData,
      this.currentOwner,
      this.transferData});

  static List<FbaseBike> listFromSnapshot(List<dynamic> snap) {
    var output = new List<FbaseBike>();
    snap.forEach((d) => output.add(FbaseBike.createBikeFromSnapshot(d)));
    return output;
  }

  static FbaseBike createBikeFromSnapshot(dynamic snap) {
    var map = Map<String, dynamic>.from(snap);
    var idData = BikeIdData.fromSnapshot(map['idData']);
    var versicherungsData =
        BikeVersicherungsData.fromSnapshot(snap['versicherungsData']);
    var transferData = BikeTransferData.fromSnapshot(snap['transferData']);
    List<String> pictures;
    if (snap['pictures'] != null)
      pictures = List<String>.from(snap['pictures']);

    return FbaseBike(
        rahmenNummer: snap['rahmenNr'],
        idData: idData,
        versicherungsData: versicherungsData,
        currentOwner: snap['currentOwner'],
        transferData: transferData)
      ..pictures = pictures;
  }

  static List<Map<String, dynamic>> listToSnapshot(List<FbaseBike> bikes) {
    var output = new List<Map<String, dynamic>>();
    bikes.forEach((b) => output.add(b.toSnapshot()));
    return output;
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'rahmenNr': this.rahmenNummer,
      'idData': this.idData.toSnapshot(),
      'versicherungsData': this.versicherungsData.toSnapshot(),
      'transferData': this.transferData?.toSnapshot(),
      'pictures': this.pictures,
      'currentOwner': this.currentOwner,
    };
  }
}

class BikeIdData {
  String name;
  String art;
  String modell;
  String hersteller;
  String groesse;
  String farbe;
  String beschreibung;
  int registerDate;
  bool isStolen = false;

  BikeIdData(
      {this.name,
      this.art,
      this.modell,
      this.hersteller,
      this.groesse,
      this.farbe,
      this.beschreibung,
      this.registerDate,
      this.isStolen});

  static BikeIdData fromSnapshot(dynamic input) {
    var snap = Map<String, dynamic>.from(input);

    return BikeIdData(
      name: snap['name'],
      art: snap['art'],
      modell: snap['modell'],
      hersteller: snap['hersteller'],
      groesse: snap['groesse'],
      farbe: snap['farbe'],
      beschreibung: snap['beschreibung'],
      registerDate: snap['registerDate'],
      isStolen: snap['isStolen'],
    );
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'name': this.name,
      'art': this.art,
      'modell': this.modell,
      'hersteller': this.hersteller,
      'groesse': this.groesse,
      'farbe': this.farbe,
      'beschreibung': this.beschreibung,
      'registerDate': this.registerDate,
      'isStolen': this.isStolen
    };
  }
}

class BikeVersicherungsData {
  String gesellschaft;
  String nummer;

  BikeVersicherungsData({this.gesellschaft, this.nummer});

  static BikeVersicherungsData fromSnapshot(dynamic input) {
    var snap = Map<String, dynamic>.from(input);

    return BikeVersicherungsData(
        gesellschaft: snap['gesellschaft'], nummer: snap['nummer']);
  }

  Map<String, dynamic> toSnapshot() =>
      {'gesellschaft': this.gesellschaft, 'nummer': this.nummer};
}

class BikeTransferData {
  String pin;
  String intendedFor;
  int date_milliseconds;
  String generatedBy;
  String gestellNr;

  BikeTransferData({
    this.pin,
    this.intendedFor,
    this.date_milliseconds,
    this.generatedBy,
    this.gestellNr,
  });

  static Future<BikeTransferData> generateNewPin(String intendedFor,
      String generatedBy, String gestellNr, String uID) async {
    String pin = "";
    FbaseBike bike;
    do {
      pin = "";
      var rng =
          new Random(uID.hashCode + DateTime.now().millisecondsSinceEpoch);
      for (var i = 0; i < 7; i++) pin += rng.nextInt(10).toString();

      bike = await FireStoreWorker.checkIfPinIsAlreadyTaken(pin);
    } while (bike != null);

    return BikeTransferData(
        date_milliseconds: DateTime.now().millisecondsSinceEpoch,
        pin: pin,
        gestellNr: gestellNr,
        intendedFor: intendedFor,
        generatedBy: generatedBy);
  }

  static BikeTransferData fromSnapshot(dynamic input) {
    if (input == null) return null;
    var snap = Map<String, dynamic>.from(input);

    return BikeTransferData(
      pin: snap['pin'],
      intendedFor: snap['intendedFor'],
      date_milliseconds: snap['date_milliseconds'],
      generatedBy: snap['generatedBy'],
      gestellNr: snap['rahmenNr'],
    );
  }

  Map<String, dynamic> toSnapshot() => {
        'pin': this.pin,
        'intendedFor': this.intendedFor,
        'date_milliseconds': this.date_milliseconds,
        'generatedBy': this.generatedBy,
        'rahmenNr': this.gestellNr,
      };
}
