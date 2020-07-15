import 'dart:async';
import '../constant.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Connected with ChangeNotifier {
  final _controller = StreamController<bool>();

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        return true;
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
