import 'package:flutter/foundation.dart';


class AccountData {
  String id;
  String name;
  String phone;
  String address;
  String slogan;
  String logo;
  String email;

  AccountData({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.slogan,
    @required this.logo,
    @required this.email,
  });
}