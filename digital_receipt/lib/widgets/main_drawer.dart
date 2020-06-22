import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/screens/receipt_history.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 60.0, left: 5.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Reecpy',
                style: TextStyle(
                    fontFamily: 'MuseoModerno',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.6),
              ),
            ),

            SizedBox(height: 20.0),

            ListTile(
              title: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image(
                        image: AssetImage(
                            'assets/images/degeit_1.png'
                        ),
                        height: 36.0,
                        width: 134.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 20.0
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Account',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                            Icons.receipt,
                            color: Colors.white,
                            size: 20.0
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Receipts',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                            Icons.history,
                            color: Colors.white,
                            size: 20.0
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'History',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                            Icons.show_chart,
                            color: Colors.white,
                            size: 20.0
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Analytics',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 20.0
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Drafts',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 20.0
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Preferences',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              letterSpacing: 0.5
                          ),
                        ),
                      ],
                    ),
                    onTap: (){},
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -1.0),
            child: Container(
              width:55.0,
              height: 55.0,
              color: Color(0xFF0000),
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
