import 'dart:convert';

import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDb extends ChangeNotifier {
  Box draftBox;
  void addCustomer(Customer customer) {
    final customerBox = Hive.box('customer');
    customerBox.add(customer);
  }

  /* FOR DRAFT PAGE */

  Future<void> addDraft(List receipts) async {
    var draftBox = await Hive.openBox('draft');
    var res = json.encode(receipts);
    await draftBox.put('draft', res);
  }

  Future getDraft() async {
    // print('dfdf');
    var draftBox = await Hive.openBox('draft');
    var draft = draftBox.get('draft');
    return json.decode(draft);
  }
}
