import 'dart:io';
import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';

import 'package:digital_receipt/widgets/app_drop_selector.dart';

import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';

import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/widgets/currency_dropdown.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'no_internet_connection.dart';

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
  bool isLoading = false;
  var status;
  String selectedCurrency;

  Future getImage() async {
    PermissionStatus status = await Permission.storage.status;
    //print(status);
    /*  if (status == PermissionStatus.granted) { */
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      // print(File(pickedFile.path).lengthSync());
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
    } on PlatformException {
      return;
      //}
    }
  }

  final _setupKey = GlobalKey<FormState>();

  Widget _buildBusinesssName(formLabel) {
    return AppTextFormField(
      label: formLabel,
      validator: (value) {
        if (value.isEmpty) {
          return 'Business name empty';
        }
        return null;
      },
      onSaved: (String value) {
        businessName = value;
      },
    );
  }

  Widget _buildSlogan(formLabel) {
    return AppTextFormField(
      label: formLabel,
      validator: (value) {
        if (value.isEmpty) {
          return 'Business slogan empty';
        }
        return null;
      },
      onSaved: (String value) {
        slogan = value;
      },
    );
  }

  Widget _buildCurrency(formLabel) {
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
        AppDropSelector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CurrencyDropdown(
                    currency: Country.ALL,
                    onSubmit: (Country country) {
                      setState(() {
                        selectedCurrency = country.currency;

                        var format = NumberFormat.compactSimpleCurrency(
                            locale: 'en_US', name: country.isoCode);

                        var currency =
                            format.simpleCurrencySymbol(country.currencyISO);

                        print(format.simpleCurrencySymbol(country.currencyISO));

                        _sharedPreferenceService.addStringToSF(
                            'Currency', currency);
                      });
                    },
                  );
                },
              );
            },
            text: selectedCurrency != null ? selectedCurrency : formLabel),
      ],
    );
  }

  Widget _buildPhoneNumber(formLabel) {
    return AppTextFormField(
      label: formLabel,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Phone number empty';
        }
        return null;
      },
      onSaved: (String value) {
        phoneNumber = value;
      },
    );
  }

  Widget _buildAddress(formLabel) {
    return Column(
      children: <Widget>[
        AppTextFormField(
          label: formLabel,
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
                      child: Text('Lets help you\nset up',
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Tell us about your business. This\ninformation will show up in the receipt.',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontSize: 16)),
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
                      _buildCurrency('Currency'),
                      SizedBox(height: 22),
                      _buildSlogan('Business Slogan')
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
                    color: Colors.lightBlue[30],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _image == null ? 'Upload your logo' : "Logo uploaded",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
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
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 45),

                AppSolidButton(
                  text: 'Proceed',
                  isLoading: isLoading,
                  onPressed: () async {
                    if (_setupKey.currentState.validate()) {
                      _setupKey.currentState.save();

                      setState(() {
                        isLoading = true;
                      });
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
                          isLoading = false;
                        });
                      }
                      if (result == true) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                        Fluttertoast.showToast(
                          msg: "Your business has successfully been set up",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Sorry something went Wrong, try again",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
