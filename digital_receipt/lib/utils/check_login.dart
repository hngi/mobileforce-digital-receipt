import 'dart:async';
import 'dart:io';

import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connected.dart';

class CheckLogin with ChangeNotifier {
  // ignore: close_sinks
  final _controller = StreamController.broadcast();
  CheckLogin() {
    init();
  }

  Future<dynamic> isLoggedIn() async {
    var registrationId =
        await SharedPreferenceService().getStringValuesSF('REGISTRATION_ID');
    var connected = await Connected().checkInternet();
    if (connected) {
    
      try {
        var res =
            await http.get('$kUrlEndpoint/user/$registrationId/device/logged');
        if (res.statusCode == 200 && json.decode(res.body)['logged'] == true) {
          return true;
        } else if (res.statusCode == 200 &&
            json.decode(res.body)['logged'] != true) {
          return false;
        } else {
          return null;
        }
      } on SocketException {
        return null;
      }

      //print(registrationId);

    } else {
      return null;
    }
  }

  close() {
    _controller.close();
  }

  init() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      var id =
          await SharedPreferenceService().getStringValuesSF('REGISTRATION_ID');
      var val = await isLoggedIn();
      _controller.sink.add(val);
    });
  }

  Stream get stream => _controller.stream.asBroadcastStream();

  @override
  void dispose() {
    close();
    super.dispose();
  }
}
