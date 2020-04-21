import 'package:flutter/material.dart';
import 'package:STOBI/Features/MainPage/ui/mainPage_depricated.dart';

class SettingsDropdownDepricated extends StatefulWidget {
  final int activePage;
  final void Function(PopupPages) elementChosenCallback;

  const SettingsDropdownDepricated(
      {Key key,
      @required this.activePage,
      @required this.elementChosenCallback})
      : super(key: key);

  @override
  _SettingsDropdownDepricatedState createState() => _SettingsDropdownDepricatedState();
}

class _SettingsDropdownDepricatedState extends State<SettingsDropdownDepricated> {
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
