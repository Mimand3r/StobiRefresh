import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/ui/configs/textStyles.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/fbaseUser.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker.dart';

class BikeListElement extends StatefulWidget {
  final Bike bike;

  const BikeListElement({Key key, this.bike}) : super(key: key);

  @override
  _BikeListElementState createState() => _BikeListElementState();
}

class _BikeListElementState extends State<BikeListElement> {
  void arrowKlicked() {}

  @override
  void initState() {
    downloadAllPictues();
    super.initState();
  }

  List<File> pictures;

  Future downloadAllPictues() async {
    var bikePictures = widget.bike.pictures;
    if (bikePictures == null) return;
    if (bikePictures.length == 0) return;

    pictures = <File>[];

    for (var i = 0; i < bikePictures.length; i++) {
      var pic =
          await FireStoreWorker.downloadPictureFromStorage(bikePictures[i]);
      pictures.add(pic);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 0.7,
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Line(header: "Name", value: widget.bike.idData.name),
                          Line(
                              header: "RahmenNr",
                              value: widget.bike.rahmenNummer),
                          Line(
                              header: "Registriert",
                              value: DateTime.fromMillisecondsSinceEpoch(
                                      widget.bike.idData.registerDate)
                                  .toLocal()
                                  .toString()
                                  .split(".")[0]),
                          Line(
                              header: "Modell",
                              value: widget.bike.idData.modell),
                          Line(header: "Art", value: widget.bike.idData.art),
                          Line(
                              header: "Größe",
                              value: widget.bike.idData.groesse),
                          Line(
                              header: "Farbe", value: widget.bike.idData.farbe),
                          Line(
                              header: "Hersteller",
                              value: widget.bike.idData.hersteller),
                          Line(
                              header: "Versicherung",
                              value:
                                  widget.bike.versicherungsData.gesellschaft),
                          BikePictures(pictures)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: arrowKlicked,
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class Line extends StatefulWidget {
  const Line({Key key, @required this.header, @required this.value})
      : super(key: key);

  @override
  _LineState createState() => _LineState();

  final String header;
  final String value;
}

class _LineState extends State<Line> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Container(
                  height: 25,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.header,
                        style: myBikesLight,
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 3,
                child: Container(
                  height: 25,
                  child: Center(
                      child: Text(
                    widget.value,
                    style: myBikesStrong,
                  )),
                ))
          ],
        ),
      ],
    );
  }
}

class BikePictures extends StatefulWidget {
  final List<File> pictures;

  const BikePictures(this.pictures, {Key key}) : super(key: key);

  @override
  _BikePicturesState createState() => _BikePicturesState();
}

class _BikePicturesState extends State<BikePictures> {
  @override
  Widget build(BuildContext context) {
    if (widget.pictures == null) return Container();
    if (widget.pictures.length == 0) return Container();

    var picList = <Widget>[];
    for (var pic in widget.pictures) {
      picList.add(Container(
        width: 40,
        child: Image.file(
          pic,
        ),
      ));
      picList.add(SizedBox(width: 2));
    }

    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Flexible(
                flex: 2,
                child: Container(
                  height: 25,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Bilder x${widget.pictures.length}",
                        style: myBikesLight,
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 3,
                child: Container(
                  height: 25,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: picList),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
