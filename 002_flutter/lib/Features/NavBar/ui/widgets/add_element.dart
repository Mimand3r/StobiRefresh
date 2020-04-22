import 'package:flutter/material.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';

class AddElement extends StatefulWidget {
  @override
  _AddElementState createState() => _AddElementState();
}

class _AddElementState extends State<AddElement> {
  void addBikeGotPressed() {
    final manager = Provider.of<SmNavbar>(context, listen: false);
    manager.switchToPage(context, Pages.addBike);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, right: 0.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: addBikeGotPressed,
          child: Container(
            color: Colors.transparent,
            width: 70,
            height: 55,
            // color: Colors.red,
            child: Transform.translate(offset: const Offset(-15, 5), child: Icon(Icons.add)),
          ),
        ),
      ),
    );
  }
}
