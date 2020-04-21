import 'package:flutter/material.dart';
import 'package:STOBI/TechnischeFeatures/FirebaseInteraction/data/entity_user.dart';

class UserCreationPage extends StatefulWidget {

  final E_User storedUser;

  const UserCreationPage({Key key, this.storedUser}) : super(key: key);

  @override
  _UserCreationPageState createState() => _UserCreationPageState();
}

class _UserCreationPageState extends State<UserCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}