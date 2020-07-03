import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/screens/account_page.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditAccountInfoScreen extends StatefulWidget {
  EditAccountInfoScreen({Key key}) : super(key: key);

  @override
  _EditAccountInfoScreenState createState() => _EditAccountInfoScreenState();
}

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void submitOrder(){
   print('submitted');
  }
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
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
             child: Column(
      children: [
        SizedBox(height: 30),
        Text(
          'Tell us about your business. This information will show up in the receipt',
          style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 14,
              fontFamily: 'Montserrat',
              height: 1.43),
        ),
        Container(
      padding: EdgeInsets.only(top: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Bussiness name'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
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
          Text('Phone number'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
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
          Text('Addresss'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
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
          Text('Bussiness slogan(optional)'),
          SizedBox(
            height: 5.0,
          ),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF2B2B2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
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
          onPressed: () => submitOrder(),
          color: Theme.of(context).primaryColor,
          child: Text(
            'Update',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.30),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        )
      ],
    )
            ),
          ),
        ),
      ),
    );
  }
}

