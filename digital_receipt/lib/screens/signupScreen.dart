import 'dart:convert';
import 'dart:io';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';

import '../colors.dart';
import '../utils/receipt_util.dart';
import 'package:digital_receipt/screens/otp_auth.dart';
import 'package:digital_receipt/screens/setup.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  LoadingIndicator _loadingIndicator = LoadingIndicator(isLoading: false);

  bool passwordVisible = false;
  var _formKey = GlobalKey<FormState>();
  var _email, _password, _name;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "555414249433-qg0gt6hv2assajrufmcgtpi1bu3u02ts.apps.googleusercontent.com",
    scopes: <String>[
      'profile',
      'email',
    ],
  );

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  ApiService _apiService = ApiService();

  @override
  void dispose() {
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                  child: Container(
                    height: 50.0 + 20,
                    width: 134.0 + 20,
                    padding: EdgeInsets.all(10),
                    color: LightMode.backgroundColor,
                    child: kLogo1,
                  ),
                ),
                SizedBox(height: 40.0),
                Text("Sign Up", style: Theme.of(context).textTheme.headline5),
                SizedBox(
                  height: 5,
                ),
                Text("Create an account",
                    style: Theme.of(context).textTheme.subtitle2),
                SizedBox(
                  height: 22,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppTextFormField(
                        label: 'Username',
                        focusNode: _nameFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            _changeFocus(from: _nameFocus, to: _emailFocus),
                        keyboardType: TextInputType.text,
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
                      AppTextFormField(
                        label: 'Email Address',
                        focusNode: _emailFocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) =>
                            _changeFocus(from: _emailFocus, to: _passwordFocus),
                        keyboardType: TextInputType.emailAddress,
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
                      AppTextFormField(
                        label: 'Password',
                        focusNode: _passwordFocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          _passwordFocus.unfocus();
                        

                          /* if (!_loadingIndicator.isLoading &&
                              _formKey.currentState.validate()) {
                           // signupUser();
                          } */

                        },
                        obscureText: !passwordVisible ? true : false,
                        suffixIcon: IconButton(
                          icon: passwordVisible
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.visibility_off),
                          color: Theme.of(context).disabledColor,
                          onPressed: () {
                            setState(() => passwordVisible = !passwordVisible);
                          },
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
                              'Special Character eg.(\$\ % # & @ _ ^)')
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
                AppSolidButton(
                  text: "Sign Up",
                  height: 45,
                  isLoading: _loadingIndicator.button == AppButton.PLAIN
                      ? _loadingIndicator.isLoading
                      : false,
                  onPressed: () {
                    if (!_loadingIndicator.isLoading &&
                        _formKey.currentState.validate()) {
                      signUpUser();
                    }
                  },
                ),
                /* Container(
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
                          style: Theme.of(context).textTheme.subtitle2,
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
 */
                /*Platform.isIOS
                    ? Column(
                        children: <Widget>[
                          AppSolidButton(
                            text: "Sign in with Apple",
                            textColor: Color(0xffE5E5E5),
                            prefixIcon: Image.asset(
                                "assets/logos/apple-logo.png",
                                height: 25),
                            backgroundColor: Color(0xff121212),
                            isLoading:
                                _loadingIndicator.button == CustomButton.APPLE
                                    ? _loadingIndicator.isLoading
                                    : false,
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                AppSolidButton(
                    text: "Sign in with Google",
                    textColor: Color(0xff121212),
                    prefixIcon:
                        Image.asset("assets/logos/google-logo.png", height: 25),
                    backgroundColor: Color(0xffF2F8FF),
                    isLoading: _loadingIndicator.button == CustomButton.GOOGLE
                        ? _loadingIndicator.isLoading
                        : false,
                    onPressed: () {
                      if (!_loadingIndicator.isLoading) {
                        googleSignup();
                      }
                    }),*/
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

  signUpUser() async {
    FocusScope.of(context).unfocus();

    _formKey.currentState.save();
    setState(() {
      isLoading = true;
      _loadingIndicator =
          LoadingIndicator(isLoading: true, button: AppButton.PLAIN);
    });
    var internet = await Connected().checkInternet();
    if (!internet) {
      await showDialog(
        context: context,
        builder: (context) {
          return NoInternet();
        },
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    print('im res');
    var response = await _apiService.otpVerification(_email, _password, _name);
    setState(() {
      isLoading = false;
      _loadingIndicator = LoadingIndicator(isLoading: false);
    });

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
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
      var res = jsonDecode(response.body);
      var error = res['error'];
      Fluttertoast.showToast(
        msg: error,
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry an error occured try again',
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    }
  }

  googleSignUp() async {
    FocusScope.of(context).unfocus();

    try {
      setState(() {
        isLoading = true;
        _loadingIndicator =
            LoadingIndicator(isLoading: true, button: AppButton.GOOGLE);
      });
      final googleUser = await _googleSignIn.signIn();
      print("Passed");
      if (googleUser == null) {
        setState(() {
          isLoading = false;
          _loadingIndicator = LoadingIndicator(isLoading: false);
        });
        Fluttertoast.showToast(
          msg: 'Sign In operation cancelled by user',
          fontSize: 12,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
        return;
      } else {
        print("oKAY");
      }

      final googleAuthentication = await googleUser.authentication;
      print(googleUser.email);

      final authCredential = GoogleAuthProvider.getCredential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      await _firebaseAuth.signInWithCredential(authCredential);
      var response = await _apiService.googleSignup(
          googleAuthentication.accessToken, googleUser.email);
      if (response == "true") {
        print("Successfull!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Setup(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
          _loadingIndicator = LoadingIndicator(isLoading: false);
        });
        print(response);
        Fluttertoast.showToast(
          msg: 'Sorry an error occured try again',
          fontSize: 12,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
        );
        return;
      }
    } on PlatformException catch (e) {
      print(e.message.toString());
      // return left(const AuthFailure.serverError());
      setState(() {
        isLoading = false;
        _loadingIndicator = LoadingIndicator(isLoading: false);
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

  void _changeFocus({FocusNode from, FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }
}

class LoadingIndicator {
  final bool isLoading;
  final AppButton button;

  LoadingIndicator({this.isLoading = false, this.button});
}
