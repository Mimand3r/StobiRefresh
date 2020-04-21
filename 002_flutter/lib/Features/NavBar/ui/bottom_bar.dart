import 'package:flutter/material.dart';
import 'package:STOBI/Features/NavBar/assets/resources.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void backGotClicked() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "bottomBar",
      child: Container(
        width: double.infinity,
        height: 60,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: backGotClicked,
                child: Container(child: Image.asset(back_button_path)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
