import 'dart:convert';

import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDb extends ChangeNotifier {


  /* FOR Customer PAGE */

  Future<void> addCustomer(List customer) async {
    var customerBox = await Hive.openBox('customer');
    //print(customerBox);
    var res = json.encode(customer);
    await customerBox.put('customer', res);
  }

  getCustomer() async {
     var customerBox = await Hive.openBox('customer');
    var customer = customerBox.get('customer');
    if (customerBox != null) {
      return jsonDecode(customer);
    }
  }

  /* FOR ReeceiptHistory PAGE */


  Future<void> addReceiptHistory(List receipts) async {
    var receiptHistoryBox = await Hive.openBox('receiptHistory');
    var res = json.encode(receipts);
    await receiptHistoryBox.put('receiptHistory', res);
  }

  getReceiptHistory() async {
    var receiptHistory = await Hive.openBox('receiptHistory');

    var receipt = receiptHistory.get('receiptHistory');
    if (receipt != null) {
      return jsonDecode(receipt);
    }
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
