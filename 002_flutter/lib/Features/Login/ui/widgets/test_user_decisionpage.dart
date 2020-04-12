import 'package:flutter/material.dart';
import 'package:project_stobi/Features/MainPage/ui/startPage.dart';

// Diese Page ist nur im Testing - Sie ermöglicht existierenden User zu verwerfen und nen neuen User zu erzeugen
class TestUserDecisionPage extends StatefulWidget {
  final String previousUserName;
  final void Function() createNewUserClicked;
  final void Function() keepOldUserClicked;

  const TestUserDecisionPage(
      {Key key,
      @required this.previousUserName,
      @required this.createNewUserClicked,
      @required this.keepOldUserClicked})
      : super(key: key);

  @override
  _TestUserDecisionPageState createState() => _TestUserDecisionPageState();
}

class _TestUserDecisionPageState extends State<TestUserDecisionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: widget.keepOldUserClicked,
              child: Text(
                "Existierender User gefunden\nUser \"${widget.previousUserName}\" verwenden",
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              onPressed: widget.createNewUserClicked,
              child: Text("Neuen User erzeugen"),
            ),
          ],
        ),
      ),
    );
  }
}
