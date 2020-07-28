import 'dart:convert';

import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
   //   Fluttertoast.showToast(msg: 'Offline mode Active');
      return jsonDecode(customer);
    }
  }

  /* FOR ReeceiptHistory PAGE */
  Future<void> addReceiptHistory(receipts) async {
    var customerBox = await Hive.openBox('receipt_history');
    //print(customerBox);
    var res = json.encode(receipts);
    await customerBox.put('receipts', res);
  }

  Future getReceiptHistory() async {
    var receiptHistory = await Hive.openBox('receipt_history');
    var receipts = receiptHistory.get('receipts');
    if (receipts != null) {
      dynamic res = jsonDecode(receipts);
      res = res.map((e) {
        Receipt temp = Receipt.fromJson(e);
        return temp;
      });
      //print(res);
     // Fluttertoast.showToast(msg: 'Offline mode Active');
      return List<Receipt>.from(res);
    }
    return null;
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
    //Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(draft);
  }

  /* FOR HOMESCREEN */
  Future<void> addDashboardInfo(receipts) async {
    var draftBox = await Hive.openBox('dashboard_info');
    var res = json.encode(receipts);
    await draftBox.put('dashboard_info', res);
  }

  Future getDashboardInfo() async {
    // print('dfdf');
    var draftBox = await Hive.openBox('dashboard_info');
    var draft = draftBox.get('dashboard_info');
   // Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(draft);
  }

  /* FOR ANALYTIC PAGE */
  Future<void> addReceiptAnalytic(List receipts) async {
    var analyticBox = await Hive.openBox('analytics');
    var res = json.encode(receipts);
    await analyticBox.put('analytics', res);
  }

  Future getAnalyticData() async {
    var analyticBox = await Hive.openBox('analytics');
    var analyticData = analyticBox.get('analytics');
    //Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(analyticData);
  }

  /* FOR NOTIFICATION PAGE */
  Future<void> addNotification(dynamic notification) async {
    var notificationBox = await Hive.openBox('notification');
    var res = json.encode(notification);

    await notificationBox.put('notification', res);
  }

  Future getNotification() async {
    var notificationBox = await Hive.openBox('notification');
    var notificationData = notificationBox.get('notification');
    //Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(notificationData);
  }

  /* FOR ReeceiptHistory PAGE */
  Future<void> addInventory(inventories) async {
    var inventoryBox = await Hive.openBox('inventories');
    //print(customerBox);
    var res = json.encode(inventories);
    await inventoryBox.put('inventories', res);
  }

  Future getInventory() async {
    var inventory = await Hive.openBox('inventories');
    var inventories = inventory.get('inventories');
    if (inventories != null) {
      dynamic res = jsonDecode(inventories);
      res = res.map((e) {
        Inventory temp = Inventory.fromJson(e);
        return temp;
      });
     /* Fluttertoast.showToast(msg: 'Offline mode Active'); */
      return List<Inventory>.from(res);
    }
    return null;
  }
}
