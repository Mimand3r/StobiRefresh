import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/ui/widgets/loading_widget.dart';

class SearchingPageDepricated extends StatefulWidget {
  SearchingPageDepricated(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.userWillFahrradSuchenCallback,
      @required this.currentlySearchingABike})
      : super(key: key);

  final double height;
  final double width;
  final bool currentlySearchingABike;

  final void Function(String) userWillFahrradSuchenCallback;

  _SearchingPageDepricatedState createState() => _SearchingPageDepricatedState();
}

class _SearchingPageDepricatedState extends State<SearchingPageDepricated> {
  FocusNode focusNode;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = TextEditingController();
  }

  void fieldSubmitted(BuildContext context, String value) {
    if (value == "") return;
    focusNode.unfocus();
    controller.clear();
    widget.userWillFahrradSuchenCallback(value);
  }

  void weggeklickt(BuildContext context) {
    focusNode.unfocus();
    controller.clear();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentlySearchingABike)
      return LoadingWidget(
        loadingText: "Fahrrad wird gesucht",
      );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        weggeklickt(context);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: widget.width,
            height: widget.height,
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 96 / 547 * widget.height),
              SizedBox(
                width: 296 / 360 * widget.width,
                height: 21 / 547 * widget.height,
                child: FittedBox(
                  child: Text(
                    "Gestellnummer des Fahrrads eingeben",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "MaiandraGD",
                        shadows: <Shadow>[
                          Shadow(
                              color: Color(0x28000000),
                              offset: Offset(1.0, 5.0),
                              blurRadius: 4.0)
                        ]),
                  ),
                ),
              ),
              SizedBox(height: 21 / 547 * widget.height),
              Container(
                margin: EdgeInsets.only(
                    left: 64 / 360 * widget.width,
                    right: 64 / 360 * widget.width),
                child: Theme(
                  data: ThemeData(
                    primaryColor: Color(0xffeeeeee),
                    cursorColor: Colors.white,
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      hintText: "546456715232asd",
                      contentPadding: new EdgeInsets.all(5.0),
                      hintStyle: TextStyle(color: Color(0x30000000)),
                      border: OutlineInputBorder(),
                    ),
                    focusNode: focusNode,
                    controller: controller,
                    onFieldSubmitted: (s) {
                      fieldSubmitted(context, s);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
