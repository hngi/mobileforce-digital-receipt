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
          child: Column(
            children: <Widget>[
//              Container(
//                decoration: BoxDecoration(
//                ),
//              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    height: 120.0,
                    width: 105.49,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/group52.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
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
                    width: 360,
                    height: 83.0,
                    padding: EdgeInsets.only(left:16.0, right: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/frame55.png',),
                              fit: BoxFit.fitHeight
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
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
                          Text('Lifetime access',
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
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 328,
                    height: 89.0,
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/rectangle48.png',),
                              fit: BoxFit.fitHeight
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          SizedBox(width: 10.0),
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
                          Image(image: AssetImage('assets/icons/check.png'), height: 25, width: 25,)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 328,
                    height: 89.0,
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F8FF),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          SizedBox(width: 10.0),
                          Container(
                            width: 232,
                            height: 44,
                            child: Text(
                              'Send receipt history to\ncustomers',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 18.0),
                          Container(
                            width: 24,
                            height: 24,
                            child: Image(image: AssetImage('assets/icons/check.png'), height: 24, width: 24,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 328,
                    height: 43.0,
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/rectangle48.png',),
                              fit: BoxFit.fitWidth
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          SizedBox(width: 10.0),
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
                            child: Image(image: AssetImage('assets/icons/check.png'), height: 24, width: 24,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 328,
                    height: 89.0,
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F8FF),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          SizedBox(width: 10.0),
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
                            child: Image(image: AssetImage('assets/icons/check.png'), height: 24, width: 24,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 328,
                    height: 43.0,
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/rectangle48.png',),
                              fit: BoxFit.fitWidth
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          SizedBox(width: 10.0),
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
                            child: Image(image: AssetImage('assets/icons/check.png'), height: 24, width: 24,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 45.0),
                  Container(
                    color: Color(0xFFF2F8FF),
                    height: 45.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 32,
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
