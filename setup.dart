// import 'dart:html';
import 'dart:io';
import 'package:digital_receipt/screens/home_page.dart';
// import 'package:image_picker/image_picker.dart';
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
// File image;
//  final picker = ImagePicker();

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

Widget _buildBusinesssName(formLabel){
  return Column(
    children: <Widget>[
      Padding(padding:  const EdgeInsets.all(10)),
    Text(formLabel, 
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
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
      Padding(padding:  const EdgeInsets.all(5)),
    Text(formLabel, 
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
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
      Padding(padding:  const EdgeInsets.all(5)),
    Text(formLabel, 
    style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
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
    Padding(padding:  const EdgeInsets.all(5)),
    Text(formLabel, 
    style: 
    TextStyle(fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.grey, fontWeight: FontWeight.w700),
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
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _setupKey,
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: <Widget>[
                  Column(children: <Widget> [
                    Text('Lets help you\nset up', 
                    style: TextStyle(fontSize: 23.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w800, color: Colors.black54),
                    textAlign: TextAlign.justify,),
                    Text(
                    '\nTell us about your business. This information\nwill show up in the receipt.',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: Colors.grey),
                    textAlign: TextAlign.justify,
                    )
                  ],
                    ),

                  SizedBox(height: 30.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildBusinesssName('Business name'),
                        SizedBox(height: 15),
                        _buildPhoneNumber('Phone Number'),
                        SizedBox(height: 15),
                        _buildAddress('Address'),
                        SizedBox(height: 15),
                        _buildSlogan('Business Slogan (optional)')
                      ]
                    ),
                  ),
                    
                    SizedBox(height: 30.0), //Spacing

                    FlatButton(
                      onPressed: () => {},
                      textColor: Colors.black,
                      //shape: ShapeBorder(),
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 130.0, right: 130.0, top: 15.0, bottom: 15.0),
                      child: Center(
                        child: Row(
                          children: <Widget>[
                            Text('Upload your logo', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0),
                            ),
                            Icon(Icons.file_upload)
                              ],
                            ),
                      ),
                    ),
                      Text('Your logo should be in PNG format and have\na max size of 3MB (Optional)',
                         style: TextStyle(fontSize: 16, fontFamily: 'Montserrat', fontWeight: FontWeight.w300, color: Colors.grey),
                         textAlign: TextAlign.center,),
                    
                    SizedBox(height: 30),

                    FlatButton( onPressed: () => {
                      if (! _setupKey.currentState.validate()) {
                      } else {
                        _setupKey.currentState.save()
                      },

                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()))  
                    },
                    textColor: Colors.white,
                    color: Colors.blue[900],
                    padding: EdgeInsets.only(left: 130.0, right: 130.0, top: 15.0, bottom: 15.0),
                    child: Text('Proceed', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600))
                    ),
                  ],),
              )),
        ),
      )
    );
  }
}