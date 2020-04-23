import 'package:flutter/material.dart';

class NavSettings extends StatefulWidget {
  @override
  _NavSettingsState createState() => _NavSettingsState();
}

class _NavSettingsState extends State<NavSettings> {
  void optionButtonClicked() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Button ist noch nicht implementiert"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: optionButtonClicked,
          child: Container(
            width: 100,
            height: 65,
            color: Colors.transparent,
            child: Transform.translate(
              offset: const Offset(-4, 6),
              child: Icon(
                Icons.menu,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
