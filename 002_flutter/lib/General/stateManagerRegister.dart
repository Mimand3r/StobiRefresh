import 'package:STOBI/Features/BikeList/state/sm_user_bike_list.dart';
import 'package:STOBI/Features/BikeRegistration/state/registration_manager.dart';
import 'package:STOBI/Features/BikeTransfer/state/transfer_manager.dart';
import 'package:STOBI/Features/Login/state/sm_auth_module.dart';
import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

var allRegisteredProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => SmNavbar()),
  ChangeNotifierProvider(create: (_) => SmUserBikeList()),
  ChangeNotifierProvider(create: (_) => SmRegistrationManager()),
  ChangeNotifierProvider(create: (_) => SmTransfer()),
  ChangeNotifierProvider(create: (_) => SmAuthModule()),
];
