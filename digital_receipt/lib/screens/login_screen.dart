
import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/screens/forgot_password.dart';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../utils/connected.dart';
import '../services/api_service.dart';
import '../utils/connected.dart';
import 'no_internet_connection.dart';
import 'signupScreen.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordObscureText = true;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _cachedEmailText;
  Future<dynamic> _emailTextFuture;
  Widget _futureEMAILText;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  ApiService _apiService = ApiService();
  static SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  @override
  void initState() {
    super.initState();
    _emailTextFuture = _sharedPreferenceService.getStringValuesSF('EMAIL');

    //This widget had to be built in the initState method to prevent rebuild
    //when setState method is called when the user toggles the visisbility of the
    //password field. This rebuild clears the text in the email field.
    _futureEMAILText = FutureBuilder(
      future: _emailTextFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget _emptywidget = _builldTextFormFiled('');
        _cachedEmailText = snapshot.data == null ? '' : '${snapshot.data}';
        Widget _dataWidget = _builldTextFormFiled(_cachedEmailText);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _emptywidget;
        } else {
          if (snapshot.hasError)
            return _emptywidget;
          else
            return _dataWidget;
        }
      },
    );
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFF2F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 34,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: kLogo1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      letterSpacing: 0.03,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Welcome to degeit',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Email Address',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _futureEMAILText,
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF0C0C0C),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    focusNode: _passwordFocus,
                    onFieldSubmitted: (value) {
                      _passwordFocus.unfocus();
                      login();
                    },
                    controller: _passwordController,
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
                          'Special Character eg.(\$\ % # & @ _ ^)')
                    ]),
                    style: TextStyle(
                      color: Color(0xFF2B2B2B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordObscureText = !_passwordObscureText;
                            });
                          },
                          icon: _passwordObscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.remove_red_eye),
                          color: Color(0xFFC8C8C8)),
                      contentPadding: EdgeInsets.all(15),
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
                    obscureText: _passwordObscureText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ForgotPassword()));
                        print('forgotten password');
                      },
                      child: Text(
                        "Forgotten Password?",
                        style: TextStyle(
                          color: Color(0xFF25CCB3),
                          fontSize: 14,
                          letterSpacing: 0.02,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: FlatButton(
                      onPressed: () async => login(),
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: isLoading
                          ? ButtonLoadingIndicator(
                              color: Colors.white,
                              width: 20,
                              height: 20,
                            )
                          : Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      color: Color(0xFF0B57A7),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              letterSpacing: 0.02,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                            ),
                            children: [
                              TextSpan(
                                text: '  Sign up',
                                style: TextStyle(
                                  color: Color(0xFF25CCB3),
                                  fontSize: 14,
                                  letterSpacing: 0.02,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 14.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 2,
                  //         child: Divider(
                  //           thickness: 1.0,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //         child: Text(
                  //           'OR',
                  //           style: TextStyle(color: Colors.grey),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 2,
                  //         child: Divider(
                  //           thickness: 1.0,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // _buildAppleLogin(),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // _buildGoogleLogin(),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // _buildFacebookLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });

      String emailString;
      if (_cachedEmailText != null) {
        if (_emailController.text.isNotEmpty)
          emailString = _emailController.text;
        else
          emailString = _cachedEmailText;
      } else {
        emailString = _emailController.text;
      }
// check the internet
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

      String api_response = await _apiService.loginUser(
        emailString,
        _passwordController.text,
      );
      if (api_response == "true") {
        Fluttertoast.showToast(
            msg: 'Logged in successfully',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: api_response ?? 'Sorry something went Wrong, try again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void _changeFocus({FocusNode from, FocusNode to}) {
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }

  Container _buildFacebookLogin() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FlatButton.icon(
          textColor: Colors.white,
          icon: FaIcon(
            FontAwesomeIcons.facebook,
            color: Colors.white,
          ),
          onPressed: () {},
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          label: Text(
            'Continue with Facebook',
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Montserrat',
              fontSize: 15,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: Color(0xFF3b5998),
        ),
      ),
    );
  }

  Container _buildGoogleLogin() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FlatButton.icon(
          textColor: Colors.black,
          onPressed: () {},
          padding: EdgeInsets.all(10),
          icon: Image.asset('assets/images/google_logo.png'),
          label: Text(
            'Continue with Google',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 15,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildAppleLogin() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: FlatButton.icon(
            textColor: Colors.white,
            icon: FaIcon(
              FontAwesomeIcons.apple,
              color: Colors.white,
            ),
            onPressed: () {},
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            label: Text(
              'Continue with Apple',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.87),
                fontFamily: 'Montserrat',
                fontSize: 15,
                letterSpacing: 0.3,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Colors.black),
      ),
    );
  }

  Widget _builldTextFormFiled(String text) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _emailController.text = text);
    return TextFormField(
      focusNode: _emailFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) =>
          _changeFocus(from: _emailFocus, to: _passwordFocus),
      controller: _emailController,
      validator: Validators.compose([
        Validators.required('Input Email Address'),
        Validators.email('Invalid Email Address'),
      ]),
      style: TextStyle(
        color: Color(0xFF2B2B2B),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: EdgeInsets.all(15),
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
    );
  }
}
