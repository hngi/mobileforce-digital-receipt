import 'dart:io';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

final ApiService _apiService = ApiService();
final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

class _SetupState extends State<Setup> {
  String businessName;
  String address;
  String slogan;
  String phoneNumber;
  String _image;
  final picker = ImagePicker();
  bool loading = false;
  var status;

  Future getImage() async {
    PermissionStatus status = await Permission.storage.status;
    //print(status);
    /*  if (status == PermissionStatus.granted) { */
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(File(pickedFile.path).lengthSync());
    //  print('picked: $pickedFile');
    if (pickedFile != null) {
      // print(pickedFile.path);
      setState(() {
        _image = pickedFile.path;
      });
      print('image: $_image');
    } else {
      print('not able to pick file');
    }

    //}
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
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Business name empty';
            }
            return null;
          },
          onSaved: (String value) {
            businessName = value;
          },
        )
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
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          /*  validator: (value) {
            if (value.isEmpty) {
              return 'Invalid Email Address';
            }
            return null;
          }, */
          onSaved: (String value) {
            slogan = value;
          },
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
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Phone number empty';
            }
            return null;
          },
          onSaved: (String value) {
            phoneNumber = value;
          },
        )
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
              fontSize: 13.0,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.43,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(0, 0, 0, 0.12),
              ),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Address empty';
            }
            return null;
          },
          onSaved: (String value) {
            address = value;
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.teal[50],
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 40,
          ),
          child: Form(
            key: _setupKey,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tell us about your business. This\ninformation will show up in the receipt.',
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

                SizedBox(height: 22.0),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBusinesssName('Business name'),
                      SizedBox(height: 22),
                      _buildPhoneNumber('Phone Number'),
                      SizedBox(height: 22),
                      _buildAddress('Address'),
                      SizedBox(height: 22),
                      _buildSlogan('Business Slogan (optional)')
                    ]),

                SizedBox(
                  height: 50,
                ), //Spacing

                Container(
                  width: 450,
                  height: 50,
                  child: FlatButton(
                    onPressed: getImage,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                    ),
                    textColor: Colors.black,
                    color: Colors.lightBlue[30],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _image == null ? 'Upload your logo' : "Logo uploaded",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        _image == null
                            ? Icon(Icons.file_upload)
                            : Icon(Icons.check),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your logo should be in PNG format and have\na max size of 3MB (Optional)',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(0, 0, 0, 0.6)),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 45),

                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      if (_setupKey.currentState.validate()) {
                        _setupKey.currentState.save();

                        setState(() {
                          loading = true;
                        });

                        var token = await _sharedPreferenceService
                            .getStringValuesSF('AUTH_TOKEN');

                        print(_image);

                        var result = await _apiService.setUpBusiness(
                          token: token,
                          phoneNumber: phoneNumber,
                          name: businessName,
                          address: address,
                          slogan: slogan,
                          logo: _image,
                        );

                        if (result != null) {
                          setState(() {
                            loading = false;
                          });
                        }
                        if (result == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                      }
                    },
                    textColor: Colors.white,
                    color: Color(0xFF0B57A7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: loading
                        ? ButtonLoadingIndicator(
                            color: Colors.white, height: 20, width: 20)
                        : Text(
                            'Proceed',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
