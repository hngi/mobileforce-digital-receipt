import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

Connectivity connectivity = Connectivity();

class Connected with ChangeNotifier {
  StreamSubscription connectedSubscription;
  ConnectivityResult connectedStatus;
  init() {
    connectedSubscription = connectivity.onConnectivityChanged.listen((event) {
      connectedStatus = event;
      print(event);
    });
  }

  @override
  void dispose() {
    if (connectedSubscription != null) {
      connectedSubscription.cancel();
    }
    super.dispose();
  }
}
