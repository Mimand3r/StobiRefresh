import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_module_depricated.dart';
import 'package:project_stobi/TechnischeFeatures/FirebaseInteraction/firestore_worker_depricated.dart';

class MessagingModuleDepricated {

  // Singleton
  MessagingModuleDepricated._privateConstructor();
  static final MessagingModuleDepricated instance = MessagingModuleDepricated._privateConstructor();

  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  String uId;

  Future<void> init(String uId, Future Function() messageArrivedCallback) async {

    this.uId = uId;

    firebaseMessaging.requestNotificationPermissions(); // for IOS only
    
    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      await messageArrivedCallback();
      await showNotification(message['notification']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    });

    await firebaseMessaging.getToken().then((token) async{
      print('token: $token');
      await FirestoreWorker_depricated.storeUserMessageToken(uId, token);
    }).catchError((err) => Fluttertoast.showToast(msg: err.message.toString()));

    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(message) async { // on Notification Message arrived
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'dev.heino.heinos_chat_demo': 'com.duytq.flutterchatdemo', // TODO IOS?
      'Stobi - Fahrradapp',
      'Die App gegen Fahrraddiebstahl',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));
  }


}