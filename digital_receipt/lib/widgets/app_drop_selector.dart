import 'package:flutter/material.dart';

class AppDropSelector extends StatelessWidget {
  AppDropSelector({Key key, this.onTap, this.text}) : super(key: key);
  final onTap;
  final text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFFC8C8C8),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 14),
        child: Row(
          children: <Widget>[
            Text(text, style: Theme.of(context).textTheme.headline6),
            Spacer(),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
