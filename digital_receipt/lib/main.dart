<<<<<<< HEAD
import 'package:digital_receipt/screens/receipt_screen.dart';
import 'package:flutter/material.dart';
=======
import 'package:digital_receipt/screens/create_receipt_page.dart';
>>>>>>> 2f7cde729f4a012f9e8367cc4700016f9d479902
import 'package:digital_receipt/screens/home_page.dart';
import 'package:digital_receipt/screens/preference_page.dart';

<<<<<<< HEAD
void main() => runApp (MaterialApp(
  title: 'Reepcy',
  theme: ThemeData(
    primaryColor: Colors.blue[800],
  ),
  debugShowCheckedModeBanner: false,
  //home: HomePage(),
  home: ReceiptScreen(),
));

=======
import 'package:digital_receipt/screens/signin_screen.dart';
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
    
      home: SignInScreen(),
    
    );
  }
}
>>>>>>> 2f7cde729f4a012f9e8367cc4700016f9d479902
