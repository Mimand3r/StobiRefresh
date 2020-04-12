import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/config/firebase_configs.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/model_bike.dart';

class FirestoreBikeWorker {
  static Future<void> writeSingleBike(M_Bike bike) async {
    print(
        "Writing Data to Firestore - Added Element in Global Bike List - ${bike.rahmenNummer}");
    await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(bike_list_name)
        .document(bike.rahmenNummer)
        .setData(bike.toSnapshot());
  }

  static Future<M_Bike> getSingleBike(String rahmenNummer) async {
    print(
        "Reading Data from Firestore - Read Element from Global Bike List - $rahmenNummer");
    var snap = await Firestore.instance
        .collection(dbName)
        .document(dbVersion)
        .collection(bike_list_name)
        .document(rahmenNummer)
        .get();

    return M_Bike.createBikeFromSnapshot(snap);
  }

  static Future<List<M_Bike>> getMultipleBikes(
      List<String> rahmenNummern) async {
    var output = new List<M_Bike>();

    for (var nr in rahmenNummern) {
      var bike = await getSingleBike(nr);
      output.add(bike);
    }

    return output;
  }

  static Future<void> writeMultipleBikes(List<M_Bike> bikes) async =>
      bikes.forEach((bike) async => await writeSingleBike(bike));
}
