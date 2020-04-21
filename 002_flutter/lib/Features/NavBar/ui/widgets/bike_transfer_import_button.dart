import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeTransfer/ui/bike_import_page.dart';

class BikeTransferImportButton extends StatefulWidget {
  @override
  _BikeTransferImportButtonState createState() => _BikeTransferImportButtonState();
}

class _BikeTransferImportButtonState extends State<BikeTransferImportButton> {

    void _transferBikeClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => BikeImportPage()));
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
