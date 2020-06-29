import 'package:digital_receipt/screens/change_password_screen.dart';
import 'package:digital_receipt/utils/customtext.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';
import '../services/api_service.dart';
import '../services/shared_preference_service.dart';
import 'login_screen.dart';

final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

final ApiService _apiService = ApiService();

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final String username = "Geek Tutor";

  File image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue[700],

        title: Text(
          'Account',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, bottom: 116, right: 16, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 133,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF76DBC9)
                      /*  gradient: LinearGradient(
                        colors: [Colors.teal[100], Colors.teal[300]],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ) */
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Unlock Amazing Features',
                            style: CustomText.displayn,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Upgrade to premium',
                            style: CustomText.display1,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: 50,
                      constraints: BoxConstraints(
                        maxWidth: 74,
                      ),
                      //width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: image == null
                          ? Icon(Icons.verified_user)
                          : Image.file(
                              image,
                              fit: BoxFit.cover,
                            ),
                    ),
                    onTap: getImage,
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(color: Color(0xFFE7ECF1)),
                    child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 12,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  '$username',
                  style: CustomText.display1,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Edit',
                style: TextStyle(
                  color: Color(0xFF0B57A7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              InformationData(
                label: 'Email Address',
                detail: 'myemail@mail.com',
              ),
              InformationData(
                label: 'Phone No',
                detail: '892-983-240',
              ),
              InformationData(
                label: 'Address',
                detail: '5, Amphitheatre Railway Street Degit',
              ),
              InformationData(
                label: 'Bussiness Slogan',
                detail: 'We are taking over',
              ),
              SizedBox(
                height: 35,
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Change Password', style: CustomText.display3),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              SizedBox(
                height: 47,
              ),
              FlatButton(
                onPressed: () async {
                  print('in');
                  String token = await _sharedPreferenceService
                      .getStringValuesSF('AUTH_TOKEN');
                  // print('token: $token');
                  if (token != null) {
                    var res = await _apiService.logOutUser(token);
                    print(res);
                    if (res == true) {
                      print('logged out');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LogInScreen(),
                        ),
                      );
                    }
                  }
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationData extends StatelessWidget {
  final String label;
  final String detail;

  InformationData({this.label, this.detail});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              '$label : ',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                  letterSpacing: 0.03),
            ),
            Expanded(
              child: Text(
                '$detail',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 1,
          color: Color.fromRGBO(0, 0, 0, 0.12),
        ),
      ],
    );
  }
}
