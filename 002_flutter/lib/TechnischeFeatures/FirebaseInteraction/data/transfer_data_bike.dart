import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_transfer_worker.dart';
import 'model_bike.dart';

class BikeTransferData {
  String pin;
  String intendedFor;
  int creation_date_millisecs;
  String generatedBy;
  String rahmenNr;

  BikeTransferData({
    this.pin,
    this.intendedFor,
    this.creation_date_millisecs,
    this.generatedBy,
    this.rahmenNr,
  });

  static Future<void> generateNewPin(
      String intendedFor, String generatedBy, E_Bike bike) async {
    String pin = "";
    M_Bike pinBike;
    do {
      pin = "";
      var rng = new Random(
          bike.currentOwnerId.hashCode + DateTime.now().millisecondsSinceEpoch);
      for (var i = 0; i < 7; i++) pin += rng.nextInt(10).toString();

      pinBike = await FirestoreBiketransferWorker.getBikeDataFromPin(pin);
    } while (pinBike != null);

    var newTransferData = BikeTransferData(
      creation_date_millisecs: DateTime.now().millisecondsSinceEpoch,
      pin: pin,
      rahmenNr: bike.rahmenNummer,
      intendedFor: intendedFor,
      generatedBy: generatedBy,
    );

    bike.transferData = newTransferData;

    await FirestoreBiketransferWorker.writePIN(bike.toMBike());
  }

  static BikeTransferData fromSnapshot(dynamic input) {
    if (input == null) return null;

    Map<String, dynamic> snap;
    if (input is DocumentSnapshot)
      snap = Map<String, dynamic>.from(input.data);
    else
      snap = Map<String, dynamic>.from(input);

    return BikeTransferData(
      pin: snap['pin'],
      intendedFor: snap['intendedFor'],
      creation_date_millisecs: snap['date_milliseconds'],
      generatedBy: snap['generatedBy'],
      rahmenNr: snap['rahmenNr'],
    );
  }

  Map<String, dynamic> toSnapshot() => {
        'pin': this.pin,
        'intendedFor': this.intendedFor,
        'date_milliseconds': this.creation_date_millisecs,
        'generatedBy': this.generatedBy,
        'rahmenNr': this.rahmenNr,
      };
}
