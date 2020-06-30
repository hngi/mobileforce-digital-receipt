import 'dart:convert';
import 'dart:io';

import 'package:digital_receipt/screens/setup.dart';
import 'package:digital_receipt/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/api_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isloading = false;
  bool passwordVisible = false;
  var _formKey = GlobalKey<FormState>();
  var _email, _password, _name;

  ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F8FF),
        body: isloading == true
            ? LoadingIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 34,
                      ),
                      Center(
                        child:
                            Image.asset('assets/images/logo.png', height: 50),
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Create an account",
                        style: TextStyle(
                          color: Color(0xff606060),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Name",
                              style: TextStyle(
                                color: Color(0xff606060),
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8C8C8),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8C8C8),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter name";
                                  }
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex = new RegExp(pattern);
                                  if (value.length < 8) {
                                    return 'name must be more than 8 charcters';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _name = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 22),
                            Text(
                              "Email Address",
                              style: TextStyle(
                                color: Color(0xff606060),
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8C8C8),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8C8C8),
                                      width: 1,
                                    ),
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
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 22),
                            Text(
                              "Password",
                              style: TextStyle(
                                color: Color(0xff606060),
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                obscureText: !passwordVisible ? true : false,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: passwordVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.remove_red_eye),
                                    color: Colors.grey,
                                    onPressed: () {
                                      setState(() =>
                                          passwordVisible = !passwordVisible);
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Color(0xFFC8C8C8),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Enter Password";
                                  } else if (value.length < 5) {
                                    return "Password too short";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'By signing in you agree to our \n',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.02,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                height: 1.51),
                            children: [
                              TextSpan(
                                text: 'terms of service',
                                style: TextStyle(
                                  color: Color(0xFF25CCB3),
                                  fontSize: 14,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              TextSpan(
                                text: 'privacy policy',
                                style: TextStyle(
                                  color: Color(0xFF25CCB3),
                                  fontSize: 14,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      button(
                          name: "Sign Up",
                          textColor: Colors.white,
                          buttonColor: Color(0xFF0B57A7),
                          height: 45,
                          onPressed: () {}),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                      Platform.isIOS
                          ? Column(
                              children: <Widget>[
                                button(
                                    name: "Sign in with Apple",
                                    textColor: Color(0xffE5E5E5),
                                    iconPath: "assets/logos/apple-logo.png",
                                    buttonColor: Color(0xff121212)),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      button(
                        name: "Sign in with Google",
                        textColor: Color(0xff121212),
                        iconPath: "assets/logos/google-logo.png",
                        buttonColor: Color(0xffF2F8FF),
                        border: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      button(
                          name: "Sign in with Facebook",
                          textColor: Color(0xffE5E5E5),
                          iconPath: "assets/logos/facebook.png",
                          buttonColor: Color(0xFF3b5998)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget button({
    String name,
    Color textColor = const Color(0xffE5E5E5),
    String iconPath = "",
    Color buttonColor = const Color(0xff226EBE),
    bool border = false,
    Function onPressed,
    double height = 50,
  }) {
    // bool loadingSpinner = false;
    return Container(
      width: double.infinity,
      height: height,
      child: FlatButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: border
              ? BorderSide(color: Colors.black, width: 1)
              : BorderSide(color: buttonColor, width: 0),
        ),
        onPressed: () {
          // setState(() => isloading = true);
          if (_formKey.currentState.validate()) {
            onPressed == "" ? dont() : signupUser();
          }
        },
        child:
            //  loadingSpinner
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
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signupUser() async {
    _formKey.currentState.save();
    setState(() {
      isloading = true;
    });
    print('im res');
    String response = await _apiService.signinUser(_email, _password, _name);
    if (response == 'true') {
      Fluttertoast.showToast(
          msg: 'Signup successful',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green[600],
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Setup()));
    } else {
      setState(() {
        isloading = false;
      });
      var res = jsonDecode(response);
      print('${res['email_address'][0]}');
      Fluttertoast.showToast(
        msg: '${res['email_address'][0]}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

dont() {
  print('check if to login or signup');
}
