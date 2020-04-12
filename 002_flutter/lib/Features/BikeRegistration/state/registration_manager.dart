import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project_stobi/Managers/UserManager.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/entity_bike.dart';

class SmRegistrationManager with ChangeNotifier {
  Future registerBike(
      BuildContext context, E_Bike bikeData, List<File> pictureData) async {
    await UserManager.instance.registerNewBikeForUser(bikeData, pictureData);
  }
}
