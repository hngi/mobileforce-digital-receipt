import 'package:flutter/foundation.dart';

class Inventory extends ChangeNotifier {
  final String id;
  final String category;
  final String title;
  final double unitPrice;
  final int quantity;
  final double discount;
  final String unit;
  final double tax;

  Inventory(
      {this.id,
      this.category,
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

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      title: json['name'],
      quantity: json['quantity']?.round(),
      unit: json['unit'],
      unitPrice: (json['price']?.toDouble()),
      tax: parseDouble(json['tax_amount']),
      discount: parseDouble(json['discount']),
      category: json['category']['name'],
    );
  }

  static double parseDouble(dynamic value) {
    try {
      if (value is String) {
        return double.parse(value);
      } else if (value is double) {
        return value;
      } else {
        return 0.0;
      }
    } catch (e) {
      print(e);
      // return null if double.parse fails
      return null;
    }
  }

  set setInventoryList(List<Inventory> list) {
    _inventoryList = list;
    tempInventoryList = list;
    print('list: $list');
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
