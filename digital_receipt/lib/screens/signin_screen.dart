import 'package:digital_receipt/screens/home_page.dart';
import 'package:digital_receipt/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  height: 20,
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
                  height: 20,
                ),
                Text(
                  'Log In',
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
                  'Welcome to reepcy',
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
                    suffixIcon:
                        Icon(FontAwesomeIcons.eye, color: Color(0xFFC8C8C8)),
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
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgotten Password?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage())),
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    color: Color(0xFF226EB2),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen())),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.02,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            TextSpan(
                              text: '  Sign up',
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
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Divider(
                          thickness: 2.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Divider(
                          thickness: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildAppleLogin(),
                SizedBox(
                  height: 15,
                ),
                _buildFacebookLogin(),
                SizedBox(
                  height: 15,
                ),
                _buildGoogleLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildFacebookLogin() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: FlatButton.icon(
          textColor: Colors.white,
          icon: FaIcon(
            FontAwesomeIcons.facebook,
            color: Colors.white,
          ),
          onPressed: () {},
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          label: Text(
            'Continue with Facebook',
          ),
          color: Colors.blue[600],
        ),
      ),
    );
  }

  Container _buildGoogleLogin() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: FlatButton.icon(
          textColor: Colors.black,
          onPressed: () {},
          padding: EdgeInsets.all(10),
          icon: Image.asset('assets/images/google_logo.png'),
          label: Text(
            'Continue with Google',
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  Container _buildAppleLogin() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: FlatButton.icon(
            textColor: Colors.white,
            icon: Image.asset(
              'assets/images/apple_logo.png',
              color: Colors.white,
            ),
            onPressed: () {},
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            label: Text(
              'Continue with Apple',
            ),
            color: Colors.black),
      ),
    );
  }
}
