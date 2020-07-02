import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeVerificationScreen extends StatefulWidget {

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController()
    ..text = "12345";

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

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 0),
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  child: FlareActor(
                    "assets/otp.flr",
                    animation: "otp",
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                    child: Image.asset('assets/images/Layer1.png',height: 40,)),
                Padding(
                  padding: EdgeInsets.only(top: 20,left: 4,right: 260),
                  child: Text(
                    'Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10,left: 18,right: 10),
                    child: RichText(
                      text: TextSpan(
                          text: "An email was sent to you Enter the verification code contained in the email here",
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
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 50),
                          child: Container(
                            child: PinCodeTextField(
                              length: 5,
                              obsecureText: false,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v.length < 3) {
                                  return "I'm from validator";
                                } else {
                                  return null;
                                }
                              },
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  fieldHeight: 65,
                                  fieldWidth: 65,
                                ),
                              animationDuration: Duration(milliseconds: 300),
                              backgroundColor: Colors.blue.shade50,
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          )
                      ),
                    ),

                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      onPressed: () {},
                      child: Center(
                          child: Text(
                            "Continue".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(5),
                      ),
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  child: ButtonTheme(
                    height: 40,
                    child: FlatButton(
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.only(top: 0,bottom: 30),
                        child: Center(
                            child: Text(
                              "Resend Email".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
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
}