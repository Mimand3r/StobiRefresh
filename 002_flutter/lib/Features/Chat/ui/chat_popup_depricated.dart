import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_stobi/General/colors.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/data/database_types_depricated.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_module_depricated.dart';

class ChatPopupDepricated extends StatefulWidget {
  final Conversation conversationData;
  final DbUser_depricated user;
  final String chatPartnerId;
  final double width;
  final double height;

  const ChatPopupDepricated(
      {Key key,
      @required this.conversationData,
      @required this.user,
      @required this.chatPartnerId,
      @required this.width,
      @required this.height})
      : super(key: key);

  @override
  _ChatPopupDepricatedState createState() => _ChatPopupDepricatedState();
}

class _ChatPopupDepricatedState extends State<ChatPopupDepricated> with WidgetsBindingObserver{
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  dynamic currentMessages;

  @override
  void initState() {
    super.initState();
       // Observe App Closing
    WidgetsBinding.instance.addObserver(this);
  }

   @override
  void dispose() { 
    FirestoreModule_depricated.instance.leaveChatRoom(widget.conversationData.convId, widget.user);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

    @override
  void didChangeAppLifecycleState(AppLifecycleState state) { 
    switch (state) {
      case AppLifecycleState.inactive:
        FirestoreModule_depricated.instance.leaveChatRoom(widget.conversationData.convId, widget.user);
        break;
      case AppLifecycleState.paused:
        FirestoreModule_depricated.instance.leaveChatRoom(widget.conversationData.convId, widget.user);
        break;
      case AppLifecycleState.resumed:
        FirestoreModule_depricated.instance.leaveChatRoom(widget.conversationData.convId, widget.user);
        break;
      case AppLifecycleState.detached:
        FirestoreModule_depricated.instance.leaveChatRoom(widget.conversationData.convId, widget.user);  
        break;
    }
  }

  void userHatNachrichtGeschrieben(String nachricht, int nachrichtenType) {
    if (nachricht == "") return;
    FirestoreModule_depricated.instance.writeChatMessage(
        widget.conversationData, widget.user, nachricht, nachrichtenType);
    focusNode.unfocus();
    textEditingController.clear();
  }

  Widget buildListofMessages() {
    return Flexible(
      child: StreamBuilder(
        stream: FirestoreModule_depricated.instance
            .getChatMessageStream(widget.conversationData.convId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center();
          } else {
            currentMessages = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildChatBubble(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget buildChatBubble(int index, DocumentSnapshot document) {
    if (document['idFrom'] == widget.user.uId) {
      // Right (my message)
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // document['type'] == 0
          // Text
          Container(
            child: Text(
              document['content'],
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      AppColors.myChatBubble_gradient_start,
                      AppColors.myChatBubble_gradient_end
                    ]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18.0),
                  bottomRight: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                  topLeft: Radius.circular(7.0),
                )),
            margin: EdgeInsets.only(
                bottom: isLastMessage(index) ? 20.0 : 10.0, right: 10.0),
          )
        ],
      );
    }
    // Left (peer message)
    else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // document['type'] == 0
          // Text
          Container(
            child: Text(
              document['content'],
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      AppColors.otherChatBubble_gradient_start,
                      AppColors.otherChatBubble_gradient_end
                    ]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(12.0),
                  topRight: Radius.circular(3.0),
                  topLeft: Radius.circular(2.0),
                )),
            margin: EdgeInsets.only(
                bottom: isLastMessage(index) ? 20.0 : 10.0, right: 10.0),
          ),
        ],
      );
    }
  }

  Widget buildInputLeiste() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: () {}, //chooseAndUploadGaleryImage,
                color: AppColors.top_bar_gradient_start,
              ),
            ),
            color: Colors.white,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: textEditingController,
                onFieldSubmitted: (s) => userHatNachrichtGeschrieben(s, 0),
                decoration: InputDecoration.collapsed(
                  hintText: 'Schreibe etwas...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () =>
                    userHatNachrichtGeschrieben(textEditingController.text, 0),
                color: AppColors.top_bar_gradient_end,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  bool isLastMessage(int index) {
    return (index > 0 &&
            currentMessages != null &&
            currentMessages[index - 1]['idFrom'] == widget.user.uId) ||
        index == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              // margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/pictures/anonymousUser.png'))),
            ),
            SizedBox(
              width: 20.0,
            ),
            StatefulBuilder(
              builder: (c, f) {
                if (widget.conversationData.ersteller == widget.user.uId) {
                  return Text(
                      "Chat mit Finder von ${widget.conversationData.fahrradModell} - ${widget.conversationData.fahrradGestellNr}");
                } else {
                  return Text(
                      "Chat mit Besitzer von ${widget.conversationData.fahrradModell} - ${widget.conversationData.fahrradGestellNr}");
                }
              },
            )
          ],
        ),
        backgroundColor: AppColors.top_bar_gradient_start,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  AppColors.background_gradient_start,
                  AppColors.background_gradient_end,
                ])),
          ),
          Column(
            children: <Widget>[
              // List of messages
              buildListofMessages(),
              // Sticker
              // (stickerOverlayVisible ? buildSticker() : Container()),

              // Input content
              buildInputLeiste(),
            ],
          ),
        ],
      ),
    );
  }
}
