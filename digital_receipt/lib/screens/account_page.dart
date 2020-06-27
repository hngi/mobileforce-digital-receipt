import 'package:digital_receipt/utils/customtext.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[700],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          title: Text('Account'),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: 15.0, bottom: 15, right: 15, top: 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: screenHeight * 0.155,
                  width: screenWidth * 0.781,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      gradient: LinearGradient(
                        colors: [Colors.teal[200], Colors.teal[300]],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Unlock Amazing Features',
                              style: CustomText.display2,
                            ),
                            Text(
                              'Upgrade to premium',
                              style: CustomText.display1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.tealAccent),
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
                    ),
                  ),
                  Positioned(
                      left: 165,
                      top: 50,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.5),
                            color: Colors.white),
                        child: Center(
                          child: Icon(Icons.edit,
                              color: Colors.tealAccent, size: 17),
                        ),
                      )),
                ],
              ),
              Center(
                child: Text(
                  '$username',
                  style: CustomText.display1,
                ),
              ),
              Text(
                'Edit',
                style: TextStyle(color: Colors.blue),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Change Password', style: CustomText.display3),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
              InkWell(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.blue[50],
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Logout',
                                style: TextStyle(fontSize: 17),
                              ),
                              Icon(
                                Icons.directions_run,
                                color: Colors.red,
                                size: 20,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                onTap: null,
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
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Text(
                  '$label',
                  style: CustomText.display3,
                ),
                Text(' : '),
                Expanded(
                  child: Text(
                    '$detail',
                    style: CustomText.display2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
