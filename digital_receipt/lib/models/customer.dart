import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class Customer extends ChangeNotifier {
  String id;
  String name;
  String email;
  String phoneNumber;
  String address;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
  });
  List<Customer> _customerList = [];

  List<Customer> get customerList => _customerList;

  List<Customer> tempCustomerList = [];

  setName(name) => this.name = name;
  setEmail(email) => this.email = email;
  setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;
  setAddress(address) => this.address = address;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(

        id: json['id'].toString(),
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
      );

  @override
  String toString() {
    return '$id : $name : $email : $phoneNumber : $address';
  }

  static List<Customer> dummy() => [
        Customer(
            name: 'Carole Froschauer',
            email: 'Carole@gmail.com',
            phoneNumber: '+234 8123 4567 890',
            address: '2118 Thornridge Cir. Syracuse, Ikorodu'),
        Customer(
            name: 'Froooooschauer Carole',
            email: 'Froschauer@gmail.com',
            phoneNumber: '+234 8123 4567 890',
            address: '2118 Thornridge Cir. Syracuse, UAE'),
      ];

  set setCustomerList(List<Customer> value) {
    _customerList = value;
    tempCustomerList = value;
    notifyListeners();
  }

  searchCustomerList(String val) {
    //print(_customerList[0].name.contains(val));
    _customerList = tempCustomerList
        .where((e) => e.name.toLowerCase().contains(val.toLowerCase()))
        .toList();
    print('ok: $_customerList');
    print('kkk: $tempCustomerList');
    notifyListeners();
    //notifyListeners();
  }
}
