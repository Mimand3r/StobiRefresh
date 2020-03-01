import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';

class AddElement extends StatefulWidget {
  @override
  _AddElementState createState() => _AddElementState();
}

class _AddElementState extends State<AddElement> {
  void addBikeGotPressed() {
    final manager = Provider.of<SmNavbar>(context,listen: false);
    manager.switchToAddBikePage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, right: 30.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: addBikeGotPressed,
          child: Container(
            color: Colors.transparent,
            width: 50,
            height: 30,
            // color: Colors.red,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
