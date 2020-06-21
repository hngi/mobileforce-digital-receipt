import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0B57A7),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Color(0xFF0B57A7),),
          child: MainDrawer(),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF2F8FF),
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
