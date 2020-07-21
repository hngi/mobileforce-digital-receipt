import 'dart:async';
import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/material.dart';

//nav variable to accesss the current state of the navigator
final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class NoInternet extends StatefulWidget {
  @override
  NoInternetState createState() => NoInternetState();
}

class NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Color(0xFFF2F8FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //image container
                  Center(
                    child: kEggMonster,
                  ),

                  //text message
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'NO INTERNET',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black87,
                      // fontFamily: 'Montserrat',
                    ),
                  ),
                  Text(
                      'Whoops, You have awoken the Egg monster. Please check your connection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.43,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
