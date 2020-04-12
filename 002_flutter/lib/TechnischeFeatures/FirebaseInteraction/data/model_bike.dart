import 'dart:math';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/transfer_data_bike.dart';

class M_Bike {
  String rahmenNummer;
  BikeIdData idData;
  BikeVersicherungsData versicherungsData;
  List<String> pictures;
  String currentOwner;
  BikeTransferData transferData;
  bool registeredAsStolen = false;

  M_Bike({
    this.rahmenNummer,
    this.idData,
    this.versicherungsData,
    this.currentOwner,
    this.transferData,
    this.registeredAsStolen,
    this.pictures
  });

  static List<M_Bike> listFromSnapshot(List<dynamic> snap) {
    var output = new List<M_Bike>();
    snap.forEach((d) => output.add(M_Bike.createBikeFromSnapshot(d)));
    return output;
  }

  static M_Bike createBikeFromSnapshot(dynamic snap) {
    var map = Map<String, dynamic>.from(snap.data);
    var idData = BikeIdData.fromSnapshot(map['idData']);
    var versicherungsData =
        BikeVersicherungsData.fromSnapshot(snap['versicherungsData']);
    var transferData = BikeTransferData.fromSnapshot(snap['transferData']);
    List<String> pictures;
    if (snap['pictures'] != null)
      pictures = List<String>.from(snap['pictures']);

    return M_Bike(
        rahmenNummer: snap['rahmenNr'],
        idData: idData,
        versicherungsData: versicherungsData,
        currentOwner: snap['currentOwner'],
        transferData: transferData,
        registeredAsStolen: snap['registeredAsStolen'])
      ..pictures = pictures;
  }

  static List<Map<String, dynamic>> listToSnapshot(List<M_Bike> bikes) {
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
      'registeredAsStolen': this.registeredAsStolen
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

  BikeIdData(
      {this.name,
      this.art,
      this.modell,
      this.hersteller,
      this.groesse,
      this.farbe,
      this.beschreibung,
      this.registerDate});

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
        registerDate: snap['registerDate']);
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
      'registerDate': this.registerDate
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


