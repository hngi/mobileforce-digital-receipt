import 'dart:convert';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDb extends ChangeNotifier {
  /* FOR Customer PAGE */
  Future<void> addCustomer(List customer, String businessId) async {
    var customerBox = await Hive.openBox('$businessId customer');
    //print(customerBox);
    var res = json.encode(customer);
    await customerBox.put('$businessId customer', res);
  }

  getCustomer(String businessId) async {
    var customerBox = await Hive.openBox('$businessId customer');
    var customer = customerBox.get('$businessId customer');
    if (customerBox != null) {

      return jsonDecode(customer);
    }
  }

  /* FOR ReeceiptHistory PAGE */
  Future<void> addReceiptHistory(receipts, String businessId) async {
    var customerBox = await Hive.openBox('$businessId receipt_history');

    var res = json.encode(receipts);
    await customerBox.put('$businessId receipts', res);
  }

  Future getReceiptHistory(String businessId) async {
    var receiptHistory = await Hive.openBox('$businessId receipt_history');
    var receipts = receiptHistory.get('$businessId receipts');
    if (receipts != null) {
      dynamic res = jsonDecode(receipts);
      res = res.map((e) {
        Receipt temp = Receipt.fromJson(e);
        return temp;
      });

      return List<Receipt>.from(res);
    }
    return null;
  }

  /* FOR DRAFT PAGE */
  Future<void> addDraft(List receipts, String businessId) async {
    var draftBox = await Hive.openBox('$businessId draft');
    var res = json.encode(receipts);
    await draftBox.put('$businessId draft', res);
  }

  Future getDraft( String businessId) async {
    // print('dfdf');
    var draftBox = await Hive.openBox('$businessId draft');
    var draft = draftBox.get('$businessId draft');
    //Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(draft);
  }

  /* FOR HOMESCREEN */
  Future<void> addDashboardInfo(receipts, String businessId) async {
    var draftBox = await Hive.openBox('$businessId dashboard_info');
    var res = json.encode(receipts);
    await draftBox.put('$businessId dashboard_info', res);
  }

  Future getDashboardInfo(String businessId) async {
    // print('dfdf');
    var draftBox = await Hive.openBox('$businessId dashboard_info');
    var draft = draftBox.get('$businessId dashboard_info');
   // Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(draft);
  }

  /* FOR ANALYTIC PAGE */
  Future<void> addReceiptAnalytic(List receipts, String businessId) async {
    var analyticBox = await Hive.openBox('$businessId analytics');
    var res = json.encode(receipts);
    await analyticBox.put('$businessId analytics', res);
  }

  Future getAnalyticData(String businessId) async {
    var analyticBox = await Hive.openBox('$businessId analytics');
    var analyticData = analyticBox.get('$businessId analytics');
    //Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(analyticData);
  }

  /* FOR NOTIFICATION PAGE */
  Future<void> addNotification(dynamic notification, String businessId) async {
    var notificationBox = await Hive.openBox('$businessId notification');
    var res = json.encode(notification);

    await notificationBox.put('$businessId notification', res);
  }

  Future getNotification( String businessId) async {
    var notificationBox = await Hive.openBox('$businessId notification');
    var notificationData = notificationBox.get('$businessId notification');
    //Fluttertoast.showToast(msg: 'Offline mode Active');
    return json.decode(notificationData);
  }

  /* FOR LIST I=OF BUSINESSES */
  Future<void> addBusiness(dynamic business) async {
    var businessBox = await Hive.openBox('business');
    var res = json.encode(business);

    await businessBox.put('business', res);
  }

  Future getBusiness() async {
    var businessBox = await Hive.openBox('business');
    var businessData = businessBox.get('business');
  
    return json.decode(businessData);
  }

  /* FOR ReeceiptHistory PAGE */
  Future<void> addInventory(inventories, String businessId) async {
    var inventoryBox = await Hive.openBox('$businessId inventories');
    //print(customerBox);
    var res = json.encode(inventories);
    await inventoryBox.put('$businessId inventories', res);
  }

  Future getInventory(String businessId) async {
    var inventory = await Hive.openBox('$businessId inventories');
    var inventories = inventory.get('$businessId inventories');
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
