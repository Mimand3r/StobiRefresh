import 'package:flutter/material.dart';
import 'package:STOBI/Features/NavBar/ui/bottom_bar.dart';
import 'package:STOBI/Features/NavBar/ui/nav_bar.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NavBar(
          showAddElement: false,
          showNavigation: true,
          showOptions: true,
          showBikeTransferExportButton: false,
          showBikeTransferImportButton: false,
          chosenElement: 3,
          bottomBar: BottomNavBar(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              color: Colors.red,
              width: double.infinity,
              height: double.infinity,
              child: Center(child: Text("Chat Page")),
            ),
          ),
        ),
      ),
    );
  }
}
