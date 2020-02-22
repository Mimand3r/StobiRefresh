import 'package:flutter/material.dart';

class AskForNameHelper extends StatefulWidget {
  AskForNameHelper({Key key, @required this.nameWasChosenCallback}) : super(key: key);

  final void Function(String) nameWasChosenCallback;

  _AskForNameHelperState createState() => _AskForNameHelperState();
}

class _AskForNameHelperState extends State<AskForNameHelper> {
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // OnTap Background -> abbort
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            focusNode.unfocus();
            controller.clear();
          },
          child: Stack(
            children: <Widget>[
              // Background
              Container(
                color: Colors.white,
              ),
            ],
          ),
        ),

        // InputField
        Center(
          child: Container(
            margin: EdgeInsets.only(
                left: 64 / 360 * MediaQuery.of(context).size.width,
                right: 64 / 360 * MediaQuery.of(context).size.width),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.black,
                cursorColor: Colors.black,
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  labelText: "Bitte Namen eingeben",
                  contentPadding: new EdgeInsets.all(5.0),
                  hintStyle: TextStyle(color: Color(0x30000000)),
                  border: OutlineInputBorder(),
                ),
                focusNode: focusNode,
                controller: controller,
                onFieldSubmitted: (s) {
                  setState(() {
                      widget.nameWasChosenCallback(s);
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
