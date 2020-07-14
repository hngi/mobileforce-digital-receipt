import 'dart:convert';
import 'dart:io';

import 'package:digital_receipt/screens/otp_auth.dart';
import 'package:digital_receipt/screens/setup.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../services/api_service.dart';
import 'no_internet_connection.dart';
import '../constant.dart';
import 'otp_auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  bool passwordVisible = false;
  var _formKey = GlobalKey<FormState>();
  var _email, _password, _name;

  ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Image.asset('assets/images/logo.png', height: 50),
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
                      TextFormField(
                        keyboardType: TextInputType.text,
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
                        ),
                        validator: Validators.compose([
                          Validators.required('Input Name'),
                          Validators.patternRegExp(RegExp(r"^[A-Z a-z]+$"),
                              'Only alphabets are allowed'),
                          Validators.minLength(
                              3, 'Minimum of 3 characters required for Name'),
                        ]),
                        onSaved: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
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
                      TextFormField(
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
                        ),
                        validator: Validators.compose([
                          Validators.required('Input Email Address'),
                          Validators.email('Invalid Email Address'),
                        ]),
                        onSaved: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      SizedBox(height: 22),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xFF2B2B2B),
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        obscureText: !passwordVisible ? true : false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          suffixIcon: IconButton(
                            icon: passwordVisible
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.visibility_off),
                            color: Colors.grey,
                            onPressed: () {
                              setState(
                                  () => passwordVisible = !passwordVisible);
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFFC8C8C8),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(),
                        ),
                        validator: Validators.compose([
                          Validators.required('Input Password'),
                          Validators.minLength(8,
                              'Minimum of 8 characters required for Password'),
                          Validators.patternRegExp(kOneUpperCaseRegex,
                              'Password should contain at least an Uppercase letter'),
                          Validators.patternRegExp(kOneLowerCaseRegex,
                              'Password should contain at least a Lowercase letter'),
                          Validators.patternRegExp(kOneDigitRegex,
                              'Password should contain at least a Digit'),
                          Validators.patternRegExp(kOneSpecialCharRegex,
                              'Special Character eg.(\$\%#&@)')
                        ]),
                        onSaved: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
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
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 14.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       Expanded(
                //         flex: 2,
                //         child: Divider(
                //           thickness: 1.0,
                //         ),
                //       ),
                //       Padding(
                //         padding:
                //             const EdgeInsets.symmetric(horizontal: 8.0),
                //         child: Text(
                //           'OR',
                //           style: TextStyle(color: Colors.grey),
                //         ),
                //       ),
                //       Expanded(
                //         flex: 2,
                //         child: Divider(
                //           thickness: 1.0,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Platform.isIOS
                //     ? Column(
                //         children: <Widget>[
                //           button(
                //               name: "Sign in with Apple",
                //               textColor: Color(0xffE5E5E5),
                //               iconPath: "assets/logos/apple-logo.png",
                //               buttonColor: Color(0xff121212)),
                //           SizedBox(
                //             height: 20,
                //           ),
                //         ],
                //       )
                //     : SizedBox.shrink(),
                // button(
                //   name: "Sign in with Google",
                //   textColor: Color(0xff121212),
                //   iconPath: "assets/logos/google-logo.png",
                //   buttonColor: Color(0xffF2F8FF),
                //   border: true,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // button(
                //     name: "Sign in with Facebook",
                //     textColor: Color(0xffE5E5E5),
                //     iconPath: "assets/logos/facebook.png",
                //     buttonColor: Color(0xFF3b5998)),
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
            signupUser();
          }
        },
        child: isLoading
            ? ButtonLoadingIndicator(
                color: Colors.white,
                width: 20,
                height: 20,
              )
            : Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  signupUser() async {
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });

    var response = await _apiService.otpVerification(_email, _password, _name);
    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var otp = res['data']['otp'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PinCodeVerificationScreen(
            otp: "$otp",
            email: "$_email",
            password: "$_password",
            name: "$_name",
          ),
        ),
      );
    } else if (response.statusCode == 400) {
      setState(() {
        isLoading = false;
      });
      var error = res['error'];
      Fluttertoast.showToast(
        msg: error,
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Sorry an error occured try again',
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    }
  }

  dont() {
    print('check if to login or signup');
  }
}
