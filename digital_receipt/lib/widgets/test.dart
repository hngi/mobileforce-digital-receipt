import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class Testing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
          // Adobe XD layer: 'empty 1' (group)
          SizedBox(
        height: 200,
        child: kEmpty,
      ),
    ));
  }
}
