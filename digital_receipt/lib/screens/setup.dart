import 'dart:io';
import 'package:digital_receipt/screens/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {

final _setupKey = GlobalKey<FormState>(); 

String businessName;
String address;
String slogan;
String phoneNumber;
File image;
final picker = ImagePicker();

  Future getImage() async {
    var ImageSource;
        final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      image = File(pickedFile.path);
    });
  }

Widget _buildBusinesssName(formLabel){
  return Column(
    children: <Widget>[
      Padding(padding:  const EdgeInsets.all(3)),
    Container(
      alignment: Alignment.bottomLeft,
      child: Text(formLabel, 
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
      ),
    ),
    TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      validator: (String value){
        if (value.isEmpty) {
          return ('Business Name is Required');
        } else {
          onSaved: (String value){
            businessName = value;
          };
        }
      }
    )
  ],);
}

Widget _buildSlogan(formLabel){
  return Column(
    children: <Widget>[
      Padding(padding:  const EdgeInsets.all(3)),
    Container(
      alignment: Alignment.bottomLeft,
      child: Text(formLabel, 
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
      ),
    ),
    TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder()
      ),
    )
  ],);
}

Widget _buildPhoneNumber(formLabel){
  return Column(
    children: <Widget>[
      Padding(padding:  const EdgeInsets.all(3)),
    Container(
      alignment: Alignment.bottomLeft,
      child: Text(formLabel, 
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
      ),
    ),
    TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder()),

      validator: (String value){
        // return
        if (value.isEmpty) {
          return ('PhoneNumber is Required');
        } else {
          onSaved: (String value){
            phoneNumber = value;
          };
        }
      }
    )
  ],);
}

Widget _buildAddress(formLabel){
  return Column(
    children: <Widget>[
    Padding(padding:  const EdgeInsets.all(3)),
    Container(
      alignment: Alignment.bottomLeft,
      child: Text(formLabel, 
      style: 
      TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
      ),
    ),
    TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder(),),
      validator: (String value){
        if (value.isEmpty) {
          return ('Business Address is Required');
        } else {
          onSaved: (String value){
            address = value;
          };
        }
      },
    )
  ],);
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[30],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _setupKey,
                child: Padding(padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                  Column(children: <Widget> [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text('Lets help you\nset up', 
                      style: TextStyle(fontSize: 23.0, fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.justify,),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                      '\nTell us about your business. This\ninformation will show up in the receipt.',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: Colors.grey),
                      textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                    ),

                  SizedBox(height: 25.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildBusinesssName('Business name'),
                        SizedBox(height: 10),
                        _buildPhoneNumber('Phone Number'),
                        SizedBox(height: 10),
                        _buildAddress('Address'),
                        SizedBox(height: 10),
                        _buildSlogan('Business Slogan (optional)')
                      ]
                    ),
                  ),
                    
                    SizedBox(height: 40), //Spacing

                    OutlineButton(
                      onPressed: () => {getImage()},
                      borderSide: BorderSide(color: Colors.lightBlue, width: 2),
                      textColor: Colors.black,
                      //shape: ShapeBorder(),
                      color: Colors.lightBlue[30],
                      padding: EdgeInsets.only(left: 150.0, right: 150.0, top: 15.0, bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text('Upload your logo', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
                          ),
                          Icon(Icons.file_upload, size: 5.0,)
                            ],
                          ),
                    ),
                    SizedBox(height: 8),
                      Text('Your logo should be in PNG format and have\na max size of 3MB (Optional)',
                         style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300, color: Colors.grey),
                         textAlign: TextAlign.center,),
                    
                    SizedBox(height: 40),

                    FlatButton( onPressed: () => {
                      if (! _setupKey.currentState.validate()) {
                      } else {
                        _setupKey.currentState.save(),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))
                      }, 
                    },
                    textColor: Colors.white,
                    color: Colors.blue[900],
                    padding: EdgeInsets.only(left: 150.0, right: 150.0, top: 15.0, bottom: 15.0),
                    child: Text('Proceed', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600))
                    ),
                  ],),
              )),
        ),
      )
    );
  }
}