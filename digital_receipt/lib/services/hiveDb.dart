import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDb extends ChangeNotifier {
  void addCustomer(Customer customer) {
    Box<Customer> customerBox = Hive.box<Customer>('customer');
    customerBox.add(customer);
  }

  // void addDraft(Receipt receipt) {
  //   final draftBox = Hive.box('draft');
  //   draftBox.add(receipt);
  // }
}
