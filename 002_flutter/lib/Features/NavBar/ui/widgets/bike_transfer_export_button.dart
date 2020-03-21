import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';

class BikeTransferExportButton extends StatefulWidget {
  @override
  _BikeTransferExportButtonState createState() =>
      _BikeTransferExportButtonState();
}

class _BikeTransferExportButtonState extends State<BikeTransferExportButton> {
  void _transferBikeClicked() {
    var prov = Provider.of<SmNavbar>(context, listen: false);
    prov.switchToExportBikePage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 13, right: 80),
        child: GestureDetector(
          onTap: _transferBikeClicked,
          child: Container(
            width: 40,
            height: 40,
            // color: Colors.red,
            child: Icon(
              Icons.swap_horiz,
              size: 28,
            ),
            // color: Colors.red,
          ),
        ),
      ),
    );
  }
}
