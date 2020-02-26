import 'package:flutter/material.dart';

class NavSettings extends StatefulWidget {
  @override
  _NavSettingsState createState() => _NavSettingsState();
}

class _NavSettingsState extends State<NavSettings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, right: 30.0),
      child: Align(
        alignment: Alignment.topRight,
            child: Container(
          width: 50,
          height: 30,
          // color: Colors.red,
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}