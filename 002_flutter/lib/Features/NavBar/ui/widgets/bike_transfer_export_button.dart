import 'package:flutter/material.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
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
        padding: const EdgeInsets.only(top: 0, right: 70),
        child: GestureDetector(
          onTap: _transferBikeClicked,
          child: Container(
            width: 70,
            height: 55,
            color: Colors.transparent,
            child: Transform.translate(
              offset: const Offset(12, 6),
              child: Icon(
                Icons.swap_horiz,
                size: 28,
              ),
            ),
            // color: Colors.red,
          ),
        ),
      ),
    );
  }
}
