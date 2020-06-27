import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/custom_receipt.dart';
import '../screens/customerList.dart';
import '../screens/preference_page.dart';
import '../screens/receipt_history.dart';


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xFF0B57A7),
              padding: EdgeInsets.only(top: 60.0, left: 5.0),
              child: ListView(
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
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(
                              Icons.account_circle,
                              size: 20.0,
                              color: Colors.white
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
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerList()));
                      },
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                'assets/icons/customerlist.png'
                            ),
                            height: 20.0,
                            width: 20.0,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Customer List',
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
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 22.0
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Notification',
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
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 22.0
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Reminders',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReceiptHistory()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 22.0
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Receipt History',
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
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                'assets/icons/analytics.png'
                            ),
                            height: 20.0,
                            width: 20.0,
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
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){},
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage(
                                'assets/icons/drafts.png'
                            ),
                            height: 20.0,
                            width: 20.0,
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
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreferencePage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 22.0
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, -1.0),
            child: Container(
              width:52.0,
              height:100.0,
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
