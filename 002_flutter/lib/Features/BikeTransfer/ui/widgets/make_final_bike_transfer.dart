import 'package:flutter/material.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/datatype_bike.dart';

class MakeFinalBikeTransfer extends StatefulWidget {

  final String pin;
  final FbaseBike bike;

  const MakeFinalBikeTransfer({Key key, this.pin, this.bike}) : super(key: key);

  @override
  _MakeFinalBikeTransferState createState() => _MakeFinalBikeTransferState();
}

class _MakeFinalBikeTransferState extends State<MakeFinalBikeTransfer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Transfer kann beginnen"
        ),
      ],
    );
  }
}