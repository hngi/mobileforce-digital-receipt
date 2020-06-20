import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[50],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blue[800]),
          child: MainDrawer(),
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
      ),
    );
  }
}
