import 'package:flutter/material.dart';
import 'package:project_stobi/Features/Login/ui/loginPage.dart';
import 'package:project_stobi/General/stateManagerRegister.dart';
import 'package:provider/provider.dart';

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
          home: SafeArea(child: LoginPage())),
    );
  }
}
