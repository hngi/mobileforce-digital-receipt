
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExportOptionButton extends StatefulWidget{
  @override
  ExportOptionButtonState createState() => ExportOptionButtonState();
}

class ExportOptionButtonState extends State<ExportOptionButton>{
  String exportOptionItem = '';
  @override

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text(
            "Export Option: ",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          padding: EdgeInsets.fromLTRB(0,16.0,0,0),
          alignment: FractionalOffset(0, 0),
        ),
        RadioListTile(
          activeColor: Color(0xFF25CCB3),
          groupValue: exportOptionItem,
          title: Text('Jpeg'),
          value: 'jpeg',
          onChanged: (value){
            setState(() {
              exportOptionItem = value;

            });
          },
        ),

        RadioListTile(
          activeColor: Color(0xFF25CCB3),
          groupValue: exportOptionItem,
          title: Text('Pdf'),
          value: 'pdf',
          onChanged: (value){
            setState(() {
              exportOptionItem = value;
            });
          },
        ),

      ],
    );

  }
}