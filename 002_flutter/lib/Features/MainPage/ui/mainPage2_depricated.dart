// import 'package:flutter/material.dart';
// import 'package:STOBI/Features/BikeList/ui/page_mybikes.dart';
// import 'package:STOBI/Features/BikeSearch/ui/page_bike_search.dart';
// import 'package:STOBI/Features/Chat/ui/chat_page.dart';
// import 'package:STOBI/Features/MainPage/ui/startPage.dart';
// import 'package:STOBI/Features/NavBar/state/smanager_navbar.dart';
// import 'package:STOBI/Features/NavBar/ui/bottom_bar.dart';
// import 'package:provider/provider.dart';

// class MainPage2Depricated extends StatefulWidget {
//   @override
//   _MainPage2DepricatedState createState() => _MainPage2DepricatedState();
// }

// class _MainPage2DepricatedState extends State<MainPage2Depricated> {
//   @override
//   Widget build(BuildContext context) {

//     var navbarManager = Provider.of<SmNavbar>(context, listen: false);

//     Future.microtask(() {
//       navbarManager.showOptions = true;
//       navbarManager.showAddElement = false;
//       navbarManager.showPageNavigation = true;
//       navbarManager.updateNavBar();
//     });

//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Consumer<SmNavbar>(
//           builder: (context, state, child) {
//             switch (state.activePage) {
//               case Pages.home:
//                 return StartPage();
//               case Pages.myBikes:
//                 return Column(
//                   children: <Widget>[
//                     PageMyBikes(),
//                     Hero(
//                       tag: "bottomBar",
//                       child: BottomNavBar(
//                         isPopup: false,
//                       ),
//                     )
//                   ],
//                 );
//               case Pages.search:
//                 return Column(
//                   children: <Widget>[
//                     BikeSearchPage(),
//                     Hero(
//                       tag: "bottomBar",
//                       child: BottomNavBar(
//                         isPopup: false,
//                       ),
//                     )
//                   ],
//                 );
//               case Pages.chats:
//                 return Column(
//                   children: <Widget>[
//                     ChatPage(),
//                     Hero(
//                       tag: "bottomBar",
//                       child: BottomNavBar(
//                         isPopup: false,
//                       ),
//                     )
//                   ],
//                 );
//               default:
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
