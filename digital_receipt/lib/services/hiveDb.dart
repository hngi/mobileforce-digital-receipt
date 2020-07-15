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

  initDraftBox() async {
    draftBox = await Hive.openBox('draft');
   // print('object:: $draftBox');
    notifyListeners();
  }

  Future<void> addDraft(List receipts) async {
    print(draftBox);
    var res = json.encode(receipts);
    await draftBox.put('draft', res);
  }

  getDraft() {
    var draft = draftBox.get('draft');
    if (draft != null) {
      return jsonDecode(draft);
    }
  }
  
}
