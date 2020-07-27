import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Connected with ChangeNotifier {
  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 8), onTimeout: () {
        return [];
      }).catchError((e) {
        throw(e);
      });
      //print(result);
      if (result != null &&
          result.isNotEmpty &&
          result[0].rawAddress.isNotEmpty) {
        // print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
