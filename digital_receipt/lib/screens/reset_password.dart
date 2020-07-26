import 'package:digital_receipt/screens/login_screen.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../constant.dart';
//import 'package:path/path.dart';

class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({@required this.email});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _passwordObscureText = true;
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  ApiService _apiService = ApiService();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F8FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF0B57A7),
          title: Text(
            'Reset Password',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              fontSize: 16,
              //color: Colors.white,
            ),
          ),
          
        ),
        body: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 22),
                      Text(
                        "Enter your new password",
                        style: TextStyle(
                          color: Color(0xff606060),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'New Password',
                        style: TextStyle(
                          color: Color(0xff606060),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Builder(
                        builder: (_) => Form(
                          key: _formKey,
                          child: Container(
                            child: TextFormField(
                              controller: _passwordController,
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
                                        _passwordObscureText =
                                            !_passwordObscureText;
                                      });
                                    },
                                    icon: _passwordObscureText
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.remove_red_eye),
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: FlatButton(
                          //padding: EdgeInsets.all(5.0),
                          color: Color(0xFF0b56a7),
                          textTheme: ButtonTextTheme.primary,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: isLoading
                              ? ButtonLoadingIndicator(
                                  color: Colors.white,
                                  width: 20,
                                  height: 20,
                                )
                              : Text(
                                  'Reset',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                isLoading = true;
                              });
                              //print(_passwordController.text);
                              //print(widget.email);
                              var connected = await Connected().checkInternet();
                              if (!connected) {
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
                              String response =
                                  await _apiService.resetForgottenPassword(
                                      widget.email, _passwordController.text);
                              if (response == "true") {
                                setState(() {
                                  isLoading = false;
                                  _passwordController..text = "";
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogInScreen()));
                                });
                                Fluttertoast.showToast(
                                  msg: 'success',
                                  fontSize: 12,
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.grey,
                                );
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: 'error, try again',
                                    fontSize: 12,
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.red);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
