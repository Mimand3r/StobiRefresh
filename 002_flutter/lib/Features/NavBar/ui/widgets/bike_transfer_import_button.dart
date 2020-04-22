import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeTransfer/ui/bike_import_page.dart';

class BikeTransferImportButton extends StatefulWidget {
  @override
  _BikeTransferImportButtonState createState() =>
      _BikeTransferImportButtonState();
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
