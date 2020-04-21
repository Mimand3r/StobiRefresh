import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:STOBI/Managers/UserManager.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';

class SmRegistrationManager with ChangeNotifier {
  Future registerBike(
      BuildContext context, E_Bike bikeData, List<File> pictureData) async {
    await UserManager.instance.registerNewBikeForUser(bikeData, pictureData);
  }
}
