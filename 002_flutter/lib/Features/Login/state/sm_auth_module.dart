import 'package:flutter/material.dart';
import 'package:STOBI/Managers/UserManager.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';

class SmAuthModule with ChangeNotifier {
  Future<String> checkIfPreviousUserExists() async =>
      await UserManager.instance.checkIfPreviousUserExists();

  Future<E_User> readPreviousUserData() async =>
      await UserManager.instance.getPreviousUserData();

  Future<E_User> createNewUser(String name) async =>
      await UserManager.instance.createNewUser(name);
}
