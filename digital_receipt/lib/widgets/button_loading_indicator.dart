import 'package:flutter/material.dart';

class ButtonLoadingIndicator extends StatelessWidget {
  const ButtonLoadingIndicator({
    Key key,
    @required this.color,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        // backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation(color),
        strokeWidth: 1.8,
      ),
    );
  }
}
