
import 'package:flutter/material.dart';
import 'package:STOBI/Features/BikeDetail/ui/page_bike_detail.dart';
import 'package:STOBI/Features/BikeList/ui/page_mybikes.dart';
import 'package:STOBI/Features/BikeRegistration/ui/bike_registration_page.dart';
import 'package:STOBI/Features/BikeSearch/ui/page_bike_search.dart';
import 'package:STOBI/Features/Chat/ui/chat_page.dart';
import 'package:STOBI/Features/MainPage/ui/startPage.dart';

var registeredRoutes = <String, WidgetBuilder>{
  '/': (c) => StartPage(),
  '/myBikes': (c) => PageMyBikes(),
  '/myBikes/bikeDetail': (c) => PageBikeDetail(),
  '/myBikes/addBike': (c) => BikeRegistrationPage(),
  '/search': (c) => BikeSearchPage(),
  '/chat': (c) => ChatPage(),

};