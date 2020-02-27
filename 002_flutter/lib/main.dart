import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Features/Login/ui/loginPage.dart';
import 'General/colors.dart';
import 'General/stateManagerRegister.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allRegisteredProviders,
      child: MaterialApp(
          title: "Stobi",
          debugShowCheckedModeBanner: false,
          home: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                color: bgroundColor,
              ),
              SafeArea(child: LoginPage()),
            ],
          )),
    );
  }
}
