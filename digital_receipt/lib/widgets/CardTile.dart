import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final String label;
  final String amount;
  final Function displaySheet;
  final int index;


  CardTile({this.label, this.amount, this.displaySheet, this.index});


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color(0xFFeaf1f8),
      child: Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: ListTile(
          leading: Text(
            label, 
          style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Colors.black,
                  ),
          ),
          trailing: Text(
            amount, 
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Colors.black,
                  ),
            ),
          onTap: () => displaySheet(context, index),
        ),
      ),
    );
  }
}
