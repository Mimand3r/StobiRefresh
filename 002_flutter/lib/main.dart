import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/ui/loginPage.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stobi",
      home: SafeArea(child: LoginPage()),
    );
  }
}

