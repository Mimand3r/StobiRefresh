import 'package:flutter/material.dart';

class NavigationHelper{

  static void navigateTo(BuildContext context, Widget widget){
     Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => widget));
  }

  static void goBack(BuildContext context){
    Navigator.of(context).pop();
  }

  
}