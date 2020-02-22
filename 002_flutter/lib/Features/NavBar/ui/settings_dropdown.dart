import 'package:flutter/material.dart';
import 'package:project_stobi/Features/MainPage/ui/mainPage.dart';

class SettingsDropdown extends StatefulWidget {
  final int activePage;
  final void Function(PopupPages) elementChosenCallback;

  const SettingsDropdown(
      {Key key,
      @required this.activePage,
      @required this.elementChosenCallback})
      : super(key: key);

  @override
  _SettingsDropdownState createState() => _SettingsDropdownState();
}

class _SettingsDropdownState extends State<SettingsDropdown> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupPages>(
        onSelected: (chosenIndex) {
          widget.elementChosenCallback(chosenIndex);
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        itemBuilder: (context) {
          var entryList = List<PopupMenuEntry<PopupPages>>();

          entryList.add(PopupMenuItem<PopupPages>(
            value: PopupPages.UserPage,
            child: Text('User'),
          ));

          if (widget.activePage == 1) {
            entryList.add(PopupMenuDivider(
              height: 4.0,
            ));

            entryList.add(PopupMenuItem<PopupPages>(
              value: PopupPages.RegisterBikePage,
              child: Text('Fahrrad registrieren'),
            ));
          }

          return entryList;
        });
  }
}
