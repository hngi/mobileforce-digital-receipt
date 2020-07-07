import 'package:flutter/material.dart';
//import 'package:path/path.dart';



class ResetPassword extends StatelessWidget {

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            backgroundColor: Color(0xFFF2F8FF),

            appBar: AppBar(
                backgroundColor: Color(0xFF0B57A7),


                title: Text(
                    'Reset Password',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        //color: Colors.white,
                    ),
                ),
                leading: new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: () {},
                ),
            ),

            body: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(height: 22),
                            Text("Enter your new password",
                                style: TextStyle(
                                    color: Color(0xff606060),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Montserrat',
                                ),),

                            SizedBox(
                                height: 20,
                            ),
                            Text(
                                'New Password',
                                style: TextStyle(
                                    color: Color(0xff606060),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Montserrat',
                                ),
                            ),
                            SizedBox(
                                height: 5,
                            ),
                            TextFormField(
                                //controller: _passwordController,
                                validator: (value) {
                                    if (value.isEmpty) {
                                        return 'Invalid Password';
                                    }
                                    return null;
                                },
                                style: TextStyle(
                                    color: Color(0xFF2B2B2B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat',
                                ),
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
                                height: 120,
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: FlatButton(
                                //padding: EdgeInsets.all(5.0),
                                color: Color(0xFF0b56a7),
                                textTheme: ButtonTextTheme.primary,

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                    'Reset',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                    ),
                                ),
                                onPressed: () {
                                    //take this action
                                },
                            ),

                            ),
                        ],
                    ),
                )
            )
        );
    }
    }

