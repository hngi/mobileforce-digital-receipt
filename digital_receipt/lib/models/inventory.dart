import 'package:flutter/foundation.dart';

class Inventory extends ChangeNotifier {
  final String category;
  final String title;
  final double unitPrice;
  final int quantity;
  final int discount;
  final String unit;
  final int tax;

  Inventory(
      {this.category,
      this.title,
      this.unitPrice,
      this.quantity,
      this.discount,
      this.unit,
      this.tax});

  List<Inventory> _inventoryList = [];

  List<Inventory> get inventoryList => _inventoryList;

  List<Inventory> tempInventoryList = [];

  /*setName(name) => this.name = name;
  setEmail(email) => this.email = email;
  setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;
  setAddress(address) => this.address = address;*/

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
      /*name: json['name'],
    email: json['email'],
    phoneNumber: json['phoneNumber'],
    address: json['address'],*/
      );

  set setInventoryList(List<Inventory> list) {
    _inventoryList = list;
    tempInventoryList = list;
    notifyListeners();
  }

  searchInventoryList(String val) {
    //print(_inventoryList[0].name.contains(val));
    _inventoryList = tempInventoryList
        .where((e) => e.title.toLowerCase().contains(val.toLowerCase()))
        .toList();
    print('ok: $_inventoryList');
    print('kkk: $tempInventoryList');
    notifyListeners();
    //notifyListeners();
  }
}
