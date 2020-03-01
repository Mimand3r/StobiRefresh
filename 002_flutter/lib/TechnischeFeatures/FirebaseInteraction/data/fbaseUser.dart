import 'package:cloud_firestore/cloud_firestore.dart';

class FbaseUser {
  String uId;
  String name;
  String photoUrl;
  String pushToken;

  List<Bike> bikes;

  FbaseUser(
      {this.uId = "",
      this.name = "",
      this.photoUrl = "",
      this.bikes,
      this.pushToken}) {
    if (bikes == null) bikes = new List<Bike>();
  }

  static FbaseUser fromSnapshot(DocumentSnapshot snap) {
    var bikeListSnapshot = Bike.listFromSnapshot(snap.data["bikes"]);

    return FbaseUser(
        uId: snap.data['uId'],
        name: snap.data['name'],
        photoUrl: snap.data['photoUrl'],
        pushToken: snap.data['pushToken'],
        bikes: bikeListSnapshot);
  }

  Map<String, dynamic> toSnapshot() {
    var bikeListSnap = Bike.listToSnapshot(this.bikes);

    return {
      'uId': this.uId,
      'name': this.name,
      'photoUrl': this.photoUrl,
      'pushToken': this.pushToken,
      'bikes': bikeListSnap,
    };
  }
}

class Bike {
  String rahmenNummer;
  BikeIdData idData;
  BikeVersicherungsData versicherungsData;
  List<String> pictures;

  Bike({this.rahmenNummer, this.idData, this.versicherungsData});

  static List<Bike> listFromSnapshot(List<dynamic> snap) {
    var output = new List<Bike>();
    snap.forEach((d) => output.add(Bike.createBikeFromSnapshot(d)));
    return output;
  }

  static Bike createBikeFromSnapshot(dynamic snap) {
    var map = Map<String, dynamic>.from(snap);
    var idData = BikeIdData.fromSnapshot(map['idData']);
    var versicherungsData =
        BikeVersicherungsData.fromSnapshot(snap['versicherungsData']);
    List<String> pictures;
    if (snap['pictures'] != null)
      pictures = List<String>.from(snap['pictures']);

    return Bike(
        rahmenNummer: snap['rahmenNr'],
        idData: idData,
        versicherungsData: versicherungsData)
      ..pictures = pictures;
  }

  static List<Map<String, dynamic>> listToSnapshot(List<Bike> bikes) {
    var output = new List<Map<String, dynamic>>();
    bikes.forEach((b) => output.add(b.toSnapshot()));
    return output;
  }

  Map<String, dynamic> toSnapshot() {
    return {
      'rahmenNr': this.rahmenNummer,
      'idData': this.idData.toSnapshot(),
      'versicherungsData': this.versicherungsData.toSnapshot(),
      'pictures': this.pictures
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
      registerDate: snap['registerDate'],
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

  Map<String, dynamic> toSnapshot() {
    return {'gesellschaft': this.gesellschaft, 'nummer': this.nummer};
  }
}
