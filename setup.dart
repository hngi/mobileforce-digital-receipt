import 'dart:io';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  String businessName;
  String address;
  String slogan;
  String phoneNumber;
  File _image;
  final picker = ImagePicker();
  var status;

  Future getImage() async {
    status = await Permission.camera.status;
    if (status.isGranted) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final _setupKey = GlobalKey<FormState>();

  Widget _buildBusinesssName(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: (String value) {
              if (value.isEmpty) {
                return ('Business Name is Required');
              } else {
                onSaved:
                (String value) {
                  businessName = value;
                };
              }
            })
      ],
    );
  }

  Widget _buildSlogan(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(8)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(border: OutlineInputBorder()),
        )
      ],
    );
  }

  Widget _buildPhoneNumber(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: (String value) {
              // return
              if (value.isEmpty) {
                return ('PhoneNumber is Required');
              } else {
                onSaved:
                (String value) {
                  phoneNumber = value;
                };
              }
            })
      ],
    );
  }

  Widget _buildAddress(formLabel) {
    return Column(
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(3)),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            formLabel,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15.0,
                color: Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return ('Business Address is Required');
            } else {
              onSaved:
              (String value) {
                address = value;
              };
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[50],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Form(
                key: _setupKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 80),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Lets help you\nset up',
                              style: TextStyle(
                                  fontSize: 23.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '\nTell us about your business. This\ninformation will show up in the receipt.',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              textAlign: TextAlign.justify,
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 25.0),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _buildBusinesssName('Business name'),
                              SizedBox(height: 10),
                              _buildPhoneNumber('Phone Number'),
                              SizedBox(height: 10),
                              _buildAddress('Address'),
                              SizedBox(height: 10),
                              _buildSlogan('Business Slogan (optional)')
                            ]),
                      ),

                      SizedBox(height: 40), //Spacing

                      Container(
                        width: 450,
                        height: 50,
                        child: OutlineButton.icon(
                          onPressed: getImage,
                          borderSide: BorderSide(color: Colors.teal, width: 2),
                          textColor: Colors.black,
                          color: Colors.lightBlue[30],
                          label: Text(
                            'Upload your logo',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0,
                                color: Colors.black),
                          ),
                          icon: Icon(Icons.file_upload),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                          'Your logo should be in PNG format and have\na max size of 3MB (Optional)',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                          textAlign: TextAlign.center),

                      SizedBox(height: 40),

                      FlatButton(
                          onPressed: () => {
                                if (!_setupKey.currentState.validate())
                                  {}
                                else
                                  {
                                    _setupKey.currentState.save(),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()))
                                  },
                              },
                          textColor: Colors.white,
                          color: Colors.blue[900],
                          padding: EdgeInsets.only(
                              left: 160.0,
                              right: 160.0,
                              top: 15.0,
                              bottom: 15.0),
                          child: Text('Proceed',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                )),
          ),
        ));
  }
}
