import 'package:flutter/material.dart';
import 'package:project_stobi/Features/BikeList/ui/configs/textStyles.dart';

class BikeListElement extends StatefulWidget {
  @override
  _BikeListElementState createState() => _BikeListElementState();
}

class _BikeListElementState extends State<BikeListElement> {
  void arrowKlicked() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                          Line(header: "Name", value: "Placeholder"),
                          Line(header: "FahrgestellNr", value: "01756454510212"),
                          Line(header: "RegisterDate", value: "17.12.2019"),
                          Line(header: "Modell", value: "EBike"),
                          Line(header: "Größe", value: "175"),
                          Line(header: "Hersteller", value: "Placeholder"),
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
            Expanded(
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
            Expanded(
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
