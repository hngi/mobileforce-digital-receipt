import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            child: PasswordForm(),
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _currentPassword, _newPassword, _confirmNewPassword;
  ApiService _apiService = ApiService();
  bool _currentPasswordVisibity = true,
      _newPasswordVisibity = true,
      _confirmNewPasswordVisibity = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 22.0),
            child: AppTextFormField(
              label: 'Current Password',
              onSaved: (newValue) => _currentPassword = newValue,
              validator: Validators.compose([
                Validators.required('Input Password'),
                Validators.minLength(
                    8, 'Minimum of 8 characters required for Password'),
                Validators.patternRegExp(kOneUpperCaseRegex,
                    'Password should contain at least an Uppercase letter'),
                Validators.patternRegExp(kOneLowerCaseRegex,
                    'Password should contain at least a Lowercase letter'),
                Validators.patternRegExp(
                    kOneDigitRegex, 'Password should contain at least a Digit'),
                Validators.patternRegExp(
                    kOneSpecialCharRegex, 'Special Character eg.(\$\%#&@)')
              ]),
              obscureText: _currentPasswordVisibity,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _currentPasswordVisibity = !_currentPasswordVisibity;
                    });
                  },
                  icon: _currentPasswordVisibity
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.remove_red_eye),
                  color: Theme.of(context).disabledColor),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 22.0),
            child: AppTextFormField(
              label: 'New Password',
              onSaved: (newValue) => _newPassword = newValue,
              validator: Validators.compose([
                Validators.required('Input Password'),
                Validators.minLength(
                    8, 'Minimum of 8 characters required for Password'),
                Validators.patternRegExp(kOneUpperCaseRegex,
                    'Password should contain at least an Uppercase letter'),
                Validators.patternRegExp(kOneLowerCaseRegex,
                    'Password should contain at least a Lowercase letter'),
                Validators.patternRegExp(
                    kOneDigitRegex, 'Password should contain at least a Digit'),
                Validators.patternRegExp(
                    kOneSpecialCharRegex, 'Special Character eg.(\$\%#&@)')
              ]),
              obscureText: _newPasswordVisibity,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _newPasswordVisibity = !_newPasswordVisibity;
                    });
                  },
                  icon: _newPasswordVisibity
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.remove_red_eye),
                  color: Theme.of(context).disabledColor),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 22.0),
            child: AppTextFormField(
              label: 'Confirm New Password',
              onSaved: (newValue) => _confirmNewPassword = newValue,
              validator: Validators.compose([
                Validators.required('Input Password'),
                Validators.minLength(
                    8, 'Minimum of 8 characters required for Password'),
                Validators.patternRegExp(kOneUpperCaseRegex,
                    'Password should contain at least an Uppercase letter'),
                Validators.patternRegExp(kOneLowerCaseRegex,
                    'Password should contain at least a Lowercase letter'),
                Validators.patternRegExp(
                    kOneDigitRegex, 'Password should contain at least a Digit'),
                Validators.patternRegExp(
                    kOneSpecialCharRegex, 'Special Character eg.(\$\%#&@)')
              ]),
              obscureText: _confirmNewPasswordVisibity,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _confirmNewPasswordVisibity =
                          !_confirmNewPasswordVisibity;
                    });
                  },
                  icon: _confirmNewPasswordVisibity
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.remove_red_eye),
                  color: Theme.of(context).disabledColor),
            ),
          ),
          SizedBox(height: 100),
          AppSolidButton(
            height: 45,
            text: 'Update',
            isLoading: isLoading,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                setState(() {
                  isLoading = true;
                });
                var internet = await Connected().checkInternet();
                if (!internet) {
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
                String apiResponse = await _apiService.changePassword(
                    _currentPassword, _confirmNewPassword);
                if (apiResponse == "true") {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(
                    msg: "Password updated successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  _formKey.currentState.reset();
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(
                    msg: apiResponse,
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
          )
        ],
      ),
    );
  }
}
