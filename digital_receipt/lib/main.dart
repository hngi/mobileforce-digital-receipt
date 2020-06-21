import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/material.dart';


void main() => runApp (MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     MaterialApp(
    
      title: 'Reepcy',
    
      theme: ThemeData(
    
        primaryColor: Colors.blue[800],
    
        scaffoldBackgroundColor: Color(0xFFF2F8FF)
    
      ),
    
      debugShowCheckedModeBanner: false,
    
      home: HomePage(),
    
    );
  }
}
