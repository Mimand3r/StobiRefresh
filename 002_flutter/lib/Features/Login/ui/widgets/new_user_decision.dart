import 'package:flutter/material.dart';

class NewUserDecisionPage extends StatefulWidget {

  final void Function(bool) userMadeDecision;

  const NewUserDecisionPage({Key key, this.userMadeDecision}) : super(key: key); 

  @override
  _NewUserDecisionPageState createState() => _NewUserDecisionPageState();
}

class _NewUserDecisionPageState extends State<NewUserDecisionPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("data",),
          Text("data",)
        ],
      ),
    );
  }
}