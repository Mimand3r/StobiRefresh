import 'package:flutter/material.dart';

class BikeSearchPage extends StatefulWidget {
  @override
  _BikeSearchPageState createState() => _BikeSearchPageState();
}

class _BikeSearchPageState extends State<BikeSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Container(
        color: Colors.red,
        width: double.infinity,
        child: Center(
          child: Text("BikeSearch"),
        ),
      ),
    );
  }
}