import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {

  final String loadingText;

  LoadingWidget({Key key, @required this.loadingText}) : super(key: key);

  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Bitte Warten"),
                    CircularProgressIndicator(),
                    Text(widget.loadingText),
                  ],
                ),
              );
  }
}