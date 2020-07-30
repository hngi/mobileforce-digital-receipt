import 'package:flutter/material.dart';


class BorderedButton extends StatelessWidget {
  final Function onpress;
  final String title;
  final Icon icon;

  BorderedButton({this.onpress, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
   return SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () => onpress(),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$title',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    icon
                  ],
                ),
              ),
            );
  }
}