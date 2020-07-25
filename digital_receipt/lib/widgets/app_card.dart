import 'package:flutter/material.dart';

import '../constant.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    this.height,
    this.liningColor,
    this.child,
  });

  final double height;
  final Color liningColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: liningColor ?? Color(0xFF539C30),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Card(
        margin: EdgeInsets.only(left: 5.0),
        shape: kRoundedRectangleBorder,
        child: child,
      ),
    );
  }
}
