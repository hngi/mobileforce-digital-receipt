import 'package:flutter/material.dart';
// import 'package:digital_receipt/screens/home_page.dart';
import 'package:digital_receipt/screens/setup.dart';

void main() => runApp (MaterialApp(
  title: 'Reepcy',
  theme: ThemeData(
    primaryColor: Colors.blue[800],
  ),
  debugShowCheckedModeBanner: false,
  home: Setup(),
));
