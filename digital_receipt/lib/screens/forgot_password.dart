import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 130.0,
                ),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    letterSpacing: 0.03,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter your email address linked to your account. A password reset link will be sent to the email',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  'Email Address',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Invalid Email Address';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Color(0xFF2B2B2B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                ),
                SizedBox(
                  height: 213,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Request Reset Link',
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
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
