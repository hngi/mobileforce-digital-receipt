import 'dart:io';

import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isloading = false;
  bool passwordVisible = false;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                SizedBox(height: 40.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.03,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      color: Color(0xff606060),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            "Email Address",
                            style: TextStyle(
                              color: Color(0xff606060),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Email Address";
                              }
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Enter Valid Email';
                              else
                                return null;
                            }),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Color(0xff606060),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        TextFormField(
                            obscureText: !passwordVisible ? true : false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: passwordVisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.remove_red_eye),
                                color: Colors.grey,
                                onPressed: () {
                                  setState(
                                      () => passwordVisible = !passwordVisible);
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter Password";
                              } else if (value.length < 5) {
                                return "Password too short";
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'By signing in you agree to our \n',
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
                button(
                    name: "Sign Up",
                    textColor: Color(0xffE5E5E5),
                    buttonColor: Color(0xff226EBE)),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        color: Color(0xff606060),
                        thickness: 2,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                          color: Color(0xff606060),
                          fontSize: 12,
                        ),
                      ),
                      Divider(
                        color: Color(0xff606060),
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
                Platform.isIOS
                    ? button(
                        name: "Sign in with Apple",
                        textColor: Color(0xffE5E5E5),
                        iconPath: "assets/logos/apple-logo.png",
                        buttonColor: Color(0xff121212))
                    : Container(),
                button(
                  name: "Sign in with Google",
                  textColor: Color(0xff121212),
                  iconPath: "assets/logos/google-logo.png",
                  buttonColor: Color(0xffE5E5E5),
                ),
                button(
                    name: "Sign in with Facebook",
                    textColor: Color(0xffE5E5E5),
                    iconPath: "assets/logos/facebook.png",
                    buttonColor: Color(0xff226EBE)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(
      {String name,
      Color textColor = const Color(0xffE5E5E5),
      String iconPath = "",
      Color buttonColor = const Color(0xff226EBE)}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: RaisedButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () {
          // setState(() => isloading = true);
          if (_formKey.currentState.validate()) {}
        },
        child:
        //  isloading
        //     ? CircularProgressIndicator(
        //         backgroundColor: Color(0xffE5E5E5),
        //       )
        //     : 
            Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconPath == ""
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Image.asset("$iconPath", height: 25),
                          ),
                    Text(
                      "$name",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  
}
