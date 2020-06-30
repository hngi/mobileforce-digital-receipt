import 'package:flutter/material.dart';

class EditAccountInfoScreen extends StatefulWidget {
  EditAccountInfoScreen({Key key}) : super(key: key);

  @override
  _EditAccountInfoScreenState createState() => _EditAccountInfoScreenState();
}

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
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            child: EditAccountInfoForm(),
          ),
        ),
      ),
    );
  }
}

class EditAccountInfoForm extends StatelessWidget {
  const EditAccountInfoForm({Key key}) : super(key: key);

  Container _buildInputField({String label, TextInputType keyboardType}) {
    return Container(
      padding: EdgeInsets.only(top: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label),
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
            keyboardType: keyboardType,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        _buildInputField(label: 'Business name'),
        _buildInputField(
            label: 'Phone number', keyboardType: TextInputType.phone),
        _buildInputField(label: 'Address'),
        _buildInputField(label: 'Business slogan (optional)'),
        SizedBox(height: 100),
        MaterialButton(
          height: 45,
          minWidth: double.infinity,
          onPressed: () => () {},
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
    );
  }
}
