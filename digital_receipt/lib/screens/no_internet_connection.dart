import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/material.dart';


//nav variable to accesss the current state of the navigator
final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class NoInternetConnectivity extends StatefulWidget{
  @override
  NoInternetConnectivityState createState() => NoInternetConnectivityState();

}

class NoInternetConnectivityState extends State<NoInternetConnectivity>{

  StreamSubscription connectivitySubscription;

  ConnectivityResult _previousResult;

  @override
  void initState(){
    super.initState();

    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      //CHECK IF CONNECTIVITY RESULT IS NONE, DISPLAY THE NoInternetConnectivityScreen
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.push(MaterialPageRoute(
            builder: (BuildContext _) => NoInternetConnectivityScreen()
        ));
      }

      _previousResult = connectivityResult;
    });

    @override
    void dispose() {
      super.dispose();

      connectivitySubscription.cancel();
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: nav,
      home: HomePage(),
    );

  }
}

class NoInternetConnectivityScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFF2F8FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF0B57A7),
          title: Text(
            'Customer List',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              fontSize: 16,
              //color: Colors.white,
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: <Widget>[
                  //image container
                  Center(
                    child: Image.asset('assets/images/egg_monster.png'),
                  ),

                  //text message

                  Text('NO INTERNET',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black54,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  Container(
                    width: 293,
                    height: 69,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[

                        Text('Whoops, You have awoken the',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFC8C8C8),
                              height: 1.43,
                            )),

                        Text('Egg Monster',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFC8C8C8),
                              height: 1.43,
                            )),

                        Text('Please check your connection',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFC8C8C8),
                              height: 1.43,
                            )),
                      ],
                    ),
                  ),

                ],
              ),
            )
        )
    );
  }
}