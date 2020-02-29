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

  Bike({this.rahmenNummer, this.idData, this.versicherungsData});

  static List<Bike> listFromSnapshot(List<dynamic> snap) {
    var output = new List<Bike>();
    snap.forEach((d) => output.add(Bike.createBikeFromSnapshot(d)));
    return output;
  }

  static Bike createBikeFromSnapshot(Map<String, dynamic> snap) {
    var idData = BikeIdData.fromSnapshot(snap['idData']);
    var versicherungsData =
        BikeVersicherungsData.fromSnapshot(snap['versicherungsData']);

    return Bike(
        rahmenNummer: snap['rahmenNr'],
        idData: idData,
        versicherungsData: versicherungsData);
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

  static BikeIdData fromSnapshot(DocumentSnapshot snap) => BikeIdData(
        name: snap.data['name'],
        art: snap.data['art'],
        modell: snap.data['modell'],
        hersteller: snap.data['hersteller'],
        groesse: snap.data['groesse'],
        farbe: snap.data['farbe'],
        beschreibung: snap.data['beschreibung'],
        registerDate: snap.data['registerDate'],
      );

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

  static BikeVersicherungsData fromSnapshot(DocumentSnapshot snap) =>
      BikeVersicherungsData(
          gesellschaft: snap.data['gesellschaft'], nummer: snap.data['nummer']);

  Map<String, dynamic> toSnapshot() {
    return {'gesellschaft': this.gesellschaft, 'nummer': this.nummer};
  }
}
