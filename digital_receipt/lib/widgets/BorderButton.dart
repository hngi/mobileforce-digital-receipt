import 'package:flutter/material.dart';


class BorderedButton extends StatelessWidget {
  final Function onpress;
  final String title;
  final Icon icon;

  BorderedButton({this.onpress, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5) ,
        border: Border.all(
          color: Color(0xFF25CCB3),
          width: 2
        ),
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MaterialButton(onPressed: () => onpress(),
          child: Text(title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54
          ),
          )
          ),
          icon,
        ],
      ),
    );
  }
}