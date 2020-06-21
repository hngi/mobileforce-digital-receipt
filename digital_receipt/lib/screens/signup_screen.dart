import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _loadingSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Reepcy',
                    style: TextStyle(
                      color: Color(0xFF226EBE),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    letterSpacing: 0.03,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Color(0xFF0C0C0C),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFC8C8C8),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Business name',
                    hintStyle: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                   style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFC8C8C8),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Email address',
                    hintStyle: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFC8C8C8),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  obscureText: true,
                  //keyboardType: TextInputType.p,
                ),
                SizedBox(
                  height: 23,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'By signing in you agree to our ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          letterSpacing: 0.02,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                        ),
                        children: [
                          TextSpan(
                            text: 'terms of service',
                            style: TextStyle(
                              color: Color(0xFF25CCB3),
                              fontSize: 12,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          TextSpan(
                            text: 'privacy policy',
                            style: TextStyle(
                              color: Color(0xFF25CCB3),
                              fontSize: 12,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    onPressed: () {
                      setState(
                        () {
                          _loadingSpinner = true;
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:
                        /* _loadingSpinner
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            value,
                          )
                        :  */
                        Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xFF226EBE),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
