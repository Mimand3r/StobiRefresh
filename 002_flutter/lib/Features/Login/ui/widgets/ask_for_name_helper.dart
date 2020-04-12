import 'package:flutter/material.dart';

class AskForNameHelper extends StatefulWidget {
  AskForNameHelper({Key key, @required this.nameWasChosenCallback}) : super(key: key);

  final void Function(String) nameWasChosenCallback;

  _AskForNameHelperState createState() => _AskForNameHelperState();
}

class _AskForNameHelperState extends State<AskForNameHelper> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            left: 64 / 360 * MediaQuery.of(context).size.width,
            right: 64 / 360 * MediaQuery.of(context).size.width),
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.black,
            cursorColor: Colors.black,
          ),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              labelText: "Bitte Namen eingeben",
              contentPadding: new EdgeInsets.all(5.0),
              hintStyle: TextStyle(color: Color(0x30000000)),
              border: OutlineInputBorder(),
            ),
            controller: controller,
            onSubmitted: (s) => widget.nameWasChosenCallback(s),
          ),
        ),
      ),
    );
  }
}
