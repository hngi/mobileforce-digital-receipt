import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.blue[900]),
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
