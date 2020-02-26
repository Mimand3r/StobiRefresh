import 'package:flutter/material.dart';
import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/add_element.dart';
import 'package:project_stobi/Features/NavBar/ui/widgets/stobi_logo.dart';
import 'package:provider/provider.dart';

import 'widgets/navigation_page_options.dart';
import 'widgets/navigation_settings.dart';

class NavBarLogoOnly extends StatefulWidget {
  @override
  _NavBarLogoOnlyState createState() => _NavBarLogoOnlyState();
}

class _NavBarLogoOnlyState extends State<NavBarLogoOnly> {
  @override
  Widget build(BuildContext context) {
    return StobiLogo();
  }
}
