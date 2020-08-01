import 'package:flutter/foundation.dart';

class AccountData {
  String id;
  String name;
  String phone;
  String address;
  String slogan;
  String logo;
  String email;
  String signature;

  AccountData({
    @required this.id,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.slogan,
    @required this.logo,
    @required this.email,
    this.signature,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
      id: json['id'],
      name: json['name'],
      phone: json['phone_number'],
      address: json['address'],
      slogan: json['slogan'],
      logo: json['logo'],
      email: json['email_address'],
      signature: json['signature'],
    );
}
