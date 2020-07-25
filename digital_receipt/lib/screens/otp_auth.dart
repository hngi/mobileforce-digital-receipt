import 'dart:async';
import 'dart:convert';

import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/screens/reset_password.dart';
import 'package:digital_receipt/screens/setup.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:digital_receipt/widgets/loading.dart';

import '../colors.dart';
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
  LoadingIndicator _loadingIndicator = LoadingIndicator(isLoading: false);

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 50),
              Center(
                child: Container(
                  height: 50.0 + 20,
                  width: 134.0 + 20,
                  padding: EdgeInsets.all(10),
                  color: LightMode.backgroundColor,
                  child: kLogo1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 44, left: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Verification',
                    style: Theme.of(context).textTheme.headline5,
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
                      style: TextStyle(fontSize: 17)),
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
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          obsecureText: true,
                          textInputType: TextInputType.number,
                          animationType: AnimationType.fade,
                          keyboardAppearance: Theme.of(context).brightness,
                          validator: (v) {
                            if (v.length < 3) {
                              return "I'm from validator";
                            } else {
                              return null;
                            }
                          },
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          pinTheme: PinTheme(
                            borderWidth: 1,
                            shape: PinCodeFieldShape.box,
                            inactiveColor: Theme.of(context).disabledColor,
                            selectedColor: Theme.of(context).focusColor,
                            activeColor: Theme.of(context).disabledColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            fieldHeight: 50,
                            fieldWidth: 50,
                          ),
                          animationDuration: Duration(milliseconds: 200),
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
                      ),
                    ),
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
                child: AppSolidButton(
                  text: 'Continue',
                  isLoading: _loadingIndicator.button == AppButton.PLAIN
                      ? _loadingIndicator.isLoading
                      : false,
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
                        _loadingIndicator = LoadingIndicator(
                            isLoading: false, button: AppButton.PLAIN);
                      });
                      return;
                    }
                    currentText == widget.otp ? otpValid() : otpError();
                  },
                ),
                //
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: AppSolidButton(
                  height: 40,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  textColor: Theme.of(context).focusColor,
                  isLoading: _loadingIndicator.button == AppButton.OTP
                      ? _loadingIndicator.isLoading
                      : false,
                  text: "Resend OTP",
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
                          _loadingIndicator = LoadingIndicator(
                              isLoading: false, button: AppButton.OTP);
                        });
                        return;
                      }
                      try {
                        setState(() {
                          _loadingIndicator = LoadingIndicator(
                              isLoading: true, button: AppButton.OTP);
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
                          _loadingIndicator = LoadingIndicator(
                              isLoading: false, button: AppButton.OTP);
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
                          _loadingIndicator = LoadingIndicator(
                              isLoading: true, button: AppButton.OTP);
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
                            _loadingIndicator = LoadingIndicator(
                                isLoading: false, button: AppButton.OTP);
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
                          _loadingIndicator = LoadingIndicator(
                              isLoading: false, button: AppButton.OTP);
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
        _loadingIndicator =
            LoadingIndicator(isLoading: true, button: AppButton.PLAIN);
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
          _loadingIndicator =
              LoadingIndicator(isLoading: false, button: AppButton.PLAIN);
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
        _loadingIndicator =
            LoadingIndicator(isLoading: true, button: AppButton.PLAIN);
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
          _loadingIndicator =
              LoadingIndicator(isLoading: false, button: AppButton.PLAIN);
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
      _loadingIndicator =
          LoadingIndicator(isLoading: false, button: AppButton.PLAIN);
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
      _loadingIndicator =
          LoadingIndicator(isLoading: true, button: AppButton.OTP);
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
        _loadingIndicator =
            LoadingIndicator(isLoading: false, button: AppButton.OTP);
      });
      Fluttertoast.showToast(
        msg: error,
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
      );
    } else {
      setState(() {
        _loadingIndicator =
            LoadingIndicator(isLoading: false, button: AppButton.OTP);
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

class LoadingIndicator {
  final bool isLoading;
  final AppButton button;

  LoadingIndicator({this.isLoading = false, this.button});
}
