import 'dart:convert';

import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'otp_auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();

  ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: AppBar(
          backgroundColor: Color(0xffF2F8FF),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0B57A7)),
        ), */
        body: isLoading == true
            ? LoadingIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.03,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Enter your email address linked to your account. A password reset link will be sent to the email',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          'Email Address',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: Validators.compose([
                            Validators.required('Input Email Address'),
                            Validators.email('Invalid Email Address'),
                          ]),
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
                          height: 213,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var connected =
                                    await Connected().checkInternet();
                                if (!connected) {
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return NoInternet();
                                    },
                                  );

                                  return;
                                }
                                await verifyUserToResetPassword();
                              }
                            },
                            padding: EdgeInsets.all(10),
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
                                    'Request reset OTP',
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
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  verifyUserToResetPassword() async {
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    print('im res');
    Response response =
        await _apiService.forgotPasswordOtpVerification(_emailController.text);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res['data']['otp']);
      print(res['error']);
      var otp = res['data']['otp'];
      var error = res['error'];

      /* setState(() {
        isloading = false;
      }); */
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PinCodeVerificationScreen.forgotPassword(
                    otp: "$otp",
                    email: _emailController.text,
                  )));
    } else if (response.statusCode == 400) {
      var res = jsonDecode(response.body);

      var error = res['error'];
      setState(() {
        isLoading = false;
      });
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
/* 
    var res = jsonDecode(response);
    print(res['data']['otp']);
    print(res['error']);
    var otp = res['data']['otp'];
    var error = res['error'];
    if (response == null) {
      setState(() {
        isloading = false;
      });
      Fluttertoast.showToast(
        msg: error,
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey,
      );
    } else {
      setState(() {
        isloading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PinCodeVerificationScreen.forgotPassword(
                    otp: "$otp",
                    email: _emailController.text,
                  )));
    }*/
  }
}
