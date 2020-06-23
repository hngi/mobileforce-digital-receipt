//import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/cupertino.dart';

import './screens/onboarding.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reepcy',
      theme: ThemeData(
        primaryColor: Color(0xFF0B57A7),
        accentColor: Color(0xFF25CCB3),
        
        scaffoldBackgroundColor: Color(0xFFF2F8FF),
        appBarTheme: AppBarTheme(color: Color(0xFF0B57A7)),
        textTheme: TextTheme(
          button: TextStyle(
            fontFamily: 'Montserrat',
          ),
          subtitle1: TextStyle(
            fontFamily: 'Montserrat',
          ),
          bodyText1: TextStyle(
            fontFamily: 'Montserrat',
          ),
          bodyText2: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
