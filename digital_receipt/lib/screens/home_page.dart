import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Color(0xFF226EBE),
          
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Color(0xFF226EBE)),
          child: MainDrawer(),
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
