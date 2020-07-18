import 'dart:async';
import 'dart:convert';

import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/screens/reset_password.dart';
import 'package:digital_receipt/screens/setup.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:digital_receipt/widgets/loading.dart';

import 'home_page.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  String otp;
  String email;
  String name;
  String password;
  bool fp = false;
  PinCodeVerificationScreen({this.otp, this.email, this.name, this.password});

  PinCodeVerificationScreen.forgotPassword(
      {this.email, this.fp = true, this.otp});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController()
    ..text = "";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  ApiService _apiService = ApiService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.otp);
    print(widget.name);
    print(widget.email);
    print(widget.password);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                  )),
              Padding(
                padding: EdgeInsets.only(top: 44, left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 10),
                child: RichText(
                  text: TextSpan(
                      text:
                          "An email was sent to you Enter the verification code contained in the email here",
                      style: TextStyle(color: Colors.black54, fontSize: 17)),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Form(
                  key: formKey,
                  child: Container(
                    // width: MediaQuery.of(context).size.width /3,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 30, bottom: 50),
                        child: Container(
                          child: PinCodeTextField(
                            length: 4,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            obsecureText: true,
                            textInputType: TextInputType.number,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v.length < 3) {
                                return "I'm from validator";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              borderWidth: 1,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              fieldHeight: 50,
                              fieldWidth: 50,
                            ),
                            animationDuration: Duration(milliseconds: 200),
                            backgroundColor: Colors.white,
                            errorAnimationController: errorController,
                            autoDisposeControllers: false,
                            controller: textEditingController,
                            onCompleted: (value) async {
                              /*value == widget.otp
                                        ? otpValid()
                                        : otpError();*/
                            },
                            onChanged: (value) {
                              print(value);
                              print(widget.email);
                              print(widget.fp);
                              setState(() {
                                currentText = value;
                              });
                            },
                          ),
                        )),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    hasError ? "*Please fill up all the cells properly" : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                //
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    onPressed: () async {
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
                      currentText == widget.otp ? otpValid() : otpError();
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
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    color: kPrimaryColor,
                  ),
                ),
                //
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 40,
                  child: FlatButton(
                    onPressed: () async {
                      if (widget.fp == true) {
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
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          await verifyUserToResetPassword();
                          Fluttertoast.showToast(
                              msg: 'OTP sent successfully',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green[600],
                              textColor: Colors.white,
                              fontSize: 13.0);
                        } catch (error) {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: 'error occurred',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green[600],
                              textColor: Colors.white,
                              fontSize: 13.0);
                          textEditingController.clear();
                        }
                      } else {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          print('im res');
                          var response = await _apiService.otpVerification(
                              widget.email, widget.password, widget.name);
                          var res = jsonDecode(response.body);
                          if (response.statusCode == 200) {
                            var otp = res['data']['otp'];
                            Fluttertoast.showToast(
                                msg: 'OTP sent successfully',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green[600],
                                textColor: Colors.white,
                                fontSize: 13.0);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PinCodeVerificationScreen(
                                            otp: otp,
                                            email: widget.email,
                                            password: widget.password,
                                            name: widget.name)));
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: '${res.error}',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green[600],
                                textColor: Colors.white,
                                fontSize: 13.0);
                          }
                        } catch (error) {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: 'error occured',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green[600],
                              textColor: Colors.white,
                              fontSize: 13.0);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 30),
                      child: Center(
                          child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  otpValid() async {
    if (widget.fp == true) {
      setState(() {
        isLoading = true;
      });
      try {
        Fluttertoast.showToast(
            msg: "Sucessful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[600],
            textColor: Colors.white,
            fontSize: 13.0);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword(email: widget.email)));
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[600],
            textColor: Colors.white,
            fontSize: 13.0);
        textEditingController.clear();
      }
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await _apiService.signinUser(
            widget.email, widget.password, widget.name);
        await _apiService.loginUser(widget.email, widget.password);
        Fluttertoast.showToast(
            msg: "signup successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[600],
            textColor: Colors.white,
            fontSize: 13.0);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Setup()));
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[600],
            textColor: Colors.white,
            fontSize: 13.0);
        textEditingController.clear();
      }
    }
  }

  otpError() {
    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(
        msg: 'incorrect OTP',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[600],
        textColor: Colors.white,
        fontSize: 13.0);
    textEditingController.clear();
  }

  Future verifyUserToResetPassword() async {
    setState(() {
      isLoading = true;
    });
    print('im res');
    Response response =
        await _apiService.forgotPasswordOtpVerification(widget.email);
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
                    email: widget.email,
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
  }

  @override
  void dispose() {
    errorController.close();
    textEditingController.clear();

    super.dispose();
  }
}
