import 'package:flutter/material.dart';
import 'package:digital_receipt/screens/main_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[50],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer:
      Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.blue[800]),
        child: mainDrawer(),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.teal[50]
            ),
          ),
          Column(
            children: <Widget>[
            ],
          ),
        ],
      ),
    );
  }
}
