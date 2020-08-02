import 'package:flutter/foundation.dart';
import '../models/account.dart';

class Business extends ChangeNotifier {
  static String loading_text = '...';
  
  List<AccountData> userBusiness = [];

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

  toJson() {
    return <String, dynamic>{
      'id': accountData.id,
      'name': accountData.name,
      'phone': accountData.phone,
      'address': accountData.address,
      'slogan': accountData.slogan,
      'logo': '',
      'email': accountData.email,
    };
  }
}
