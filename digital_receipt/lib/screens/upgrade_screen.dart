import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpgradeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Upgrade',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 113.0,
                      width: 111.49,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/group52.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: Text(
                        'You make me blush',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      child: Text(
                        'Degeit is better with premium. Enjoy all features of degeit. Do business like a pro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0,
                          color: Colors.grey,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      height: 83,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/frame55.png',
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 12.0),
                          Text(
                            'N5000',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Lifetime access',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                       padding: EdgeInsets.only(top: 10, left: 10, right: 25, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFDFF6F3),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // SizedBox(height: 10.0),
                          //  SizedBox(width: 10.0),
                          Text(
                            'Issue receipts for half\npayments and set\nreminders for completion',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 32.0),
                          Image(
                            image: AssetImage('assets/icons/check.png'),
                            height: 25,
                            width: 25,
                          )
                        ],
                      ),
                    ),
                    Container(
                       padding: EdgeInsets.only(top: 20, left: 0, right: 25, bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F8FF),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //SizedBox(height: 10.0),
                          //SizedBox(width: 10.0),
                          Text(
                            'Send receipt history to\ncustomers',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 18.0),
                          Container(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage('assets/icons/check.png'),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                       padding: EdgeInsets.only(top: 10, left: 10, right: 25, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFDFF6F3),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // SizedBox(height: 10.0),
                          //SizedBox(width: 10.0),
                          Text(
                            'Customize receipt',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 98.0),
                          Container(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage('assets/icons/check.png'),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 0, right: 25, bottom: 20),
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F8FF),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // SizedBox(height: 10.0),
                          // SizedBox(width: 10.0),
                          Text(
                            'Reissue old reciepts',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16.0,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 82.0),
                          Container(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage('assets/icons/check.png'),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 25, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFDFF6F3),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // SizedBox(height: 10.0),
                          // SizedBox(width: 10.0),
                          Container(
                            width: 153,
                            height: 23,
                            child: Text(
                              'Analytics',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 100.0),
                          Container(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage('assets/icons/check.png'),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45.0),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
                        color: Color(0xFF0B57A7),
                        child: Text(
                          "Upgrade",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
