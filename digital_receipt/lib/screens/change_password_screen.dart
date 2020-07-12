import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/services/api_service.dart';
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Current Password'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  onSaved: (newValue) => _currentPassword = newValue,
                  validator: Validators.compose([
                    Validators.required('Input Password'),
                    Validators.minLength(
                        8, 'Minimum of 8 characters required for Password'),
                    Validators.patternRegExp(kOneUpperCaseRegex,
                        'Password should contain at least an Uppercase letter'),
                    Validators.patternRegExp(kOneLowerCaseRegex,
                        'Password should contain at least a Lowercase letter'),
                    Validators.patternRegExp(kOneDigitRegex,
                        'Password should contain at least a Digit'),
                    Validators.patternRegExp(kOneSpecialCharRegex,
                        'Special Character eg.(\$\%#&@)')
                  ]),
                  style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  obscureText: _currentPasswordVisibity,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _currentPasswordVisibity =
                                !_currentPasswordVisibity;
                          });
                        },
                        icon: _currentPasswordVisibity
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.remove_red_eye),
                        color: Color(0xFFC8C8C8)),
                    contentPadding: EdgeInsets.all(17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFC8C8C8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(),
                    errorStyle: TextStyle(height: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('New Password'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  onSaved: (newValue) => _newPassword = newValue,
                  validator: Validators.compose([
                    Validators.required('Input Password'),
                    Validators.minLength(
                        8, 'Minimum of 8 characters required for Password'),
                    Validators.patternRegExp(kOneUpperCaseRegex,
                        'Password should contain at least an Uppercase letter'),
                    Validators.patternRegExp(kOneLowerCaseRegex,
                        'Password should contain at least a Lowercase letter'),
                    Validators.patternRegExp(kOneDigitRegex,
                        'Password should contain at least a Digit'),
                    Validators.patternRegExp(kOneSpecialCharRegex,
                        'Special Character eg.(\$\%#&@)')
                  ]),
                  style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  obscureText: _newPasswordVisibity,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _newPasswordVisibity = !_newPasswordVisibity;
                          });
                        },
                        icon: _newPasswordVisibity
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.remove_red_eye),
                        color: Color(0xFFC8C8C8)),
                    contentPadding: EdgeInsets.all(17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFC8C8C8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(),
                    errorStyle: TextStyle(height: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Confirm New Password'),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  onSaved: (newValue) => _confirmNewPassword = newValue,
                  validator: Validators.compose([
                    Validators.required('Input Password'),
                    Validators.minLength(
                        8, 'Minimum of 8 characters required for Password'),
                    Validators.patternRegExp(kOneUpperCaseRegex,
                        'Password should contain at least an Uppercase letter'),
                    Validators.patternRegExp(kOneLowerCaseRegex,
                        'Password should contain at least a Lowercase letter'),
                    Validators.patternRegExp(kOneDigitRegex,
                        'Password should contain at least a Digit'),
                    Validators.patternRegExp(kOneSpecialCharRegex,
                        'Special Character eg.(\$\%#&@)')
                  ]),
                  style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  obscureText: _confirmNewPasswordVisibity,
                  decoration: InputDecoration(
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
                        color: Color(0xFFC8C8C8)),
                    contentPadding: EdgeInsets.all(17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Color(0xFFC8C8C8),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(),
                    errorStyle: TextStyle(height: 0.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          MaterialButton(
            height: 45,
            minWidth: double.infinity,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                setState(() {
                  isLoading = true;
                });
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
            color: Theme.of(context).primaryColor,
            child: isLoading
                ? ButtonLoadingIndicator(
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  )
                : Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.30),
                  ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
          )
        ],
      ),
    );
  }
}
