import 'package:flutter/foundation.dart';
import '../models/account.dart';

class Business extends ChangeNotifier {
  static String loading_text = '...';
  AccountData accountData = AccountData(
    id: loading_text,
    name: loading_text,
    phone: loading_text,
    address: loading_text,
    slogan: loading_text,
    logo: '',
    email: loading_text,
  );

  set setAccountData(AccountData val) {
    accountData = val;
    print(accountData.address);
    notifyListeners();
  }
}
