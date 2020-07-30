import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/screens/about.dart';
import 'package:digital_receipt/screens/analytics.dart';
import 'package:digital_receipt/screens/drafts.dart';
import 'package:digital_receipt/screens/inventory_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/customerList.dart';
import '../screens/preference_page.dart';
import '../screens/receipt_history.dart';
import '../screens/account_page.dart';
import '../screens/setup.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size.width);
    return Container(
      width: MediaQuery.of(context).size.width >= 600 ? 400 : 600,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColorDark,
              padding: EdgeInsets.only(top: 70.0, left: 5.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: 136,
                        height: 47,
                        child: Theme.of(context).brightness == Brightness.dark
                            ? kLogoWithTextDark
                            : kLogoWithTextLight,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                //TODO: Change this back to UpgradeScreen()
                                builder: (context) => AccountPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.account_circle,
                              size: 20.0, color: Colors.white),
                          SizedBox(width: 15.0),
                          Text(
                            'Account',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 0.5,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerList()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.contacts,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Customer List',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 0.5,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InventoryScreen()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.store, color: Colors.white, size: 22.0),
                          SizedBox(width: 15.0),
                          Text(
                            'Inventory',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
/*                   SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.notifications,
                              color: Colors.white, size: 22.0),
                          SizedBox(width: 15.0),
                          Text(
                            'Notification',
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
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ReminderPage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.access_time,
                              color: Colors.white, size: 22.0),
                          SizedBox(width: 15.0),
                          Text(
                            'Reminders',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                 */
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReceiptHistory()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.history, color: Colors.white, size: 22.0),
                          SizedBox(width: 15.0),
                          Text(
                            'Receipt History',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Analytics()),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.trending_up,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Analytics',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 0.5,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Drafts(),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.content_paste,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Drafts',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreferencePage(),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 22.0,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Preferences',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => About(),
                          ),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.info, color: Colors.white, size: 22.0),
                          SizedBox(width: 15.0),
                          Text(
                            'About',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment(0.0, -1.0),
              child: Container(
                width: 52.0,
                height: 100.0,
                color: Color(0xFF0000),
                alignment: Alignment.center,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
