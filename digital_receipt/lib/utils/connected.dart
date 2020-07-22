import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Connected with ChangeNotifier {
  final _controller = StreamController<bool>();

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 3), onTimeout: (){
            return [];
          });
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  init() {
    print('started');
    Timer.periodic(Duration(seconds: 1), (timer) async {
      var val = await checkInternet();
      _controller.sink.add(val);
    });
  }

  Stream<bool> get stream => _controller.stream;

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
