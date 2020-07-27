import 'dart:convert';

import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart'
    as loader;
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
        body: SafeArea(
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator( strokeWidth: 1.5,),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 130.0,
                      ),
                      Text('Forgot Password?',
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Enter your email address linked to your account. A password reset link will be sent to the email',
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      AppTextFormField(
                        label: 'Email Address',
                        controller: _emailController,
                        validator: Validators.compose([
                          Validators.required('Input Email Address'),
                          Validators.email('Invalid Email Address'),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 213,
                      ),
                      AppSolidButton(
                        text: 'Request reset OTP',
                        isLoading: isLoading,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var connected = await Connected().checkInternet();
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
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
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
