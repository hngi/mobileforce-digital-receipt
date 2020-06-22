import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFF2F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 34,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
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
                    'Welcome to degeit',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Email Address',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Email Address';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Color(0xFF2B2B2B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color(0xFFC8C8C8),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      errorStyle: TextStyle(height: 0.5),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Password';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Color(0xFF2B2B2B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordObscureText = !_passwordObscureText;
                            });
                          },
                          icon: _passwordObscureText
                              ? Icon(FontAwesomeIcons.solidEye)
                              : FaIcon(FontAwesomeIcons.solidEyeSlash),
                          color: Color(0xFFC8C8C8)),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Color(0xFFC8C8C8),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(),
                      errorStyle: TextStyle(height: 0.5),
                    ),
                    obscureText: _passwordObscureText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgotten Password?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        letterSpacing: 0.02,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                      },
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      color: Color(0xFF0B57A7),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                            children: [
                              TextSpan(
                                text: '  Sign up',
                                style: TextStyle(
                                  color: Color(0xFF25CCB3),
                                  fontSize: 14,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.bold,
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
                            thickness: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'OR',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Divider(
                            thickness: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildAppleLogin(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildGoogleLogin(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildFacebookLogin(),
                ],
              ),
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
        height: 50,
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
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Montserrat',
              fontSize: 15,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: Color(0xFF3b5998),
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
        height: 50,
        child: FlatButton.icon(
          textColor: Colors.black,
          onPressed: () {},
          padding: EdgeInsets.all(10),
          icon: Image.asset('assets/images/google_logo.png'),
          label: Text(
            'Continue with Google',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 15,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildAppleLogin() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FlatButton.icon(
            textColor: Colors.white,
            icon: FaIcon(
              FontAwesomeIcons.apple,
              color: Colors.white,
            ),
            onPressed: () {},
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            label: Text(
              'Continue with Apple',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.87),
                fontFamily: 'Montserrat',
                fontSize: 15,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Colors.black),
      ),
    );
  }
}
