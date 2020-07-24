import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import '../providers/business.dart';
import '../models/account.dart';
import '../services/shared_preference_service.dart';

class EditAccountInfoScreen extends StatefulWidget {
  EditAccountInfoScreen({Key key}) : super(key: key);
  @override
  _EditAccountInfoScreenState createState() => _EditAccountInfoScreenState();
}

final ApiService _apiService = ApiService();

final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Account Information',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
        // backgroundColor: Color(0xFF0B57A7),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: EditAccountInfoForm(),
          ),
        ),
      ),
    );
  }
}

class EditAccountInfoForm extends StatefulWidget {
  const EditAccountInfoForm({Key key}) : super(key: key);
  @override
  _EditAccountInfoFormState createState() => _EditAccountInfoFormState();
}

class _EditAccountInfoFormState extends State<EditAccountInfoForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String name;
  String address;
  String slogan;
  String logo;
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  Container _buildInputField(
      {String label,
      TextInputType keyboardType,
      Function onSaved,
      String initialValue}) {
    return Container(
      padding: EdgeInsets.only(top: 22.0),
      child: AppTextFormField(
        label: label,
        initialValue: initialValue,
        onSaved: onSaved,
        validator: (value) {
          /*  if (value.isEmpty $$ la) {
            return 'Invalid New Password';
          } */
          switch (label) {
            case 'Business name':
              if (value.isEmpty) {
                return 'Invalid business name';
              }
              break;
            case 'Phone number':
              if (value.isEmpty) {
                return 'Invalid phone number';
              }
              break;
            case 'Address':
              if (value.isEmpty) {
                return 'Invalid address';
              }
              break;
            case 'Business slogan (optional)':
              if (value.isEmpty) {
                return 'Invalid business slogan';
              }
              break;
            default:
          }
        },
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var initData = Provider.of<Business>(context).accountData;
    return Form(
      key: _formKey,
      //autovalidate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 30),
          Text(
            'Tell us about your business. This information will show up in the receipt',
          ),
          _buildInputField(
            initialValue: initData.name,
            label: 'Business name',
            onSaved: (String value) => name = value,
          ),
          _buildInputField(
            initialValue: initData.phone,
            label: 'Phone number',
            keyboardType: TextInputType.phone,
            onSaved: (String value) => phoneNumber = value,
          ),
          _buildInputField(
            initialValue: initData.address,
            label: 'Address',
            onSaved: (String value) => address = value,
          ),
          _buildInputField(
            initialValue: initData.slogan,
            label: 'Business slogan (optional)',
            onSaved: (String value) => slogan = value,
          ),
          SizedBox(height: 100),
          AppSolidButton(
            isLoading: loading,
            text: 'Update',
            onPressed: () async {
              // if (_formKey.currentState.validate()) {
              setState(() {
                loading = true;
              });
              _formKey.currentState.save();
              // }

              var internet = await Connected().checkInternet();
              if (!internet) {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return NoInternet();
                  },
                );
                setState(() {
                  loading = false;
                });
                return;
              }

              var email =
                  await _sharedPreferenceService.getStringValuesSF('EMAIL');
              var res = await _apiService.updateBusinessInfo(
                phoneNumber: phoneNumber,
                name: name,
                address: address,
                slogan: slogan,
              );
              if (res != null) {
                print(res['data']['id']);

                Provider.of<Business>(context, listen: false).setAccountData =
                    AccountData(
                  id: res['data']['id'],
                  name: res['data']['name'],
                  phone: res['data']['phone_number'],
                  address: res['data']['address'],
                  slogan: res['data']['slogan'],
                  logo: kReleaseMode
                      ? 'http://degeitreceipt.pythonanywhere.com${res['data']['logo']}'
                      : "http://degeittest.pythonanywhere.com${res['data']['logo']}",
                  email: email,
                );
                setState(() {
                  loading = false;
                });
                Fluttertoast.showToast(
                  msg: "Account updated successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
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
            },
          )
        ],
      ),
    );
  }
}
