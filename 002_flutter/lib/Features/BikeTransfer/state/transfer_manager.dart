import 'package:flutter/cupertino.dart';
import 'package:project_stobi/Managers/UserManager.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/worker/firestore_bike_transfer_worker.dart';

class SmTransfer with ChangeNotifier {
  Future createNewBikePIN(E_Bike bike, String emfaengerName) async =>
      await bike.generateNewPIN(purpose: emfaengerName);

  Future deleteBikePIN(E_Bike bike) async {
    await bike.removeBikePIN();
  }

  Future<E_Bike> tryGetABikeFromPIN(String pin) async => E_Bike.fromMBike(
      await FirestoreBiketransferWorker.getBikeDataFromPin(pin));

  Future transferBikeToMyself(E_Bike bike, List<Image> pictures) async {
    await UserManager.instance
        .transferBikeFromPreviousUserToCurrent(bike, pictures);
  }
}
