import 'package:project_stobi/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

var allRegisteredProviders = <SingleChildWidget>[
  ChangeNotifierProvider(
    create: (_) => SmNavbar()
  ),
];
