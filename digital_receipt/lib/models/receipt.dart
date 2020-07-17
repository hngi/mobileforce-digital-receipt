import 'dart:io';
import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/services/hiveDb.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
enum ReceiptCategory { WHATSAPP, INSTAGRAM, FACEBOOK, TWITTER, REDIT, OTHERS }

// part 'receipt.g.dart';

class Receipt extends ChangeNotifier { 
  String receiptNo;
  bool autoGenReceiptNo = true;
  String issuedDate;
  String customerName;
  String description;
  String receiptId;
  ReceiptCategory category;
  String totalAmount;
  Customer customer;
  List<Product> products;
  String primaryColorHexCode;
  bool preset = false;
  bool paidStamp = false;
  bool partPayment = false;
  bool saveCustomer = false;
  bool issued = false;
  int fonts = 20;
  String partPaymentDateTime;
  String signature;
  TimeOfDay reminderTime;
  DateTime reminderDate;
  num total;
  Currency currency;

  String get descriptions {
    var desc = new StringBuffer();
    if (products != null) {
      products.forEach((element) {
        desc.write('${element.productDesc} x ${element.quantity}, ');
      });
    }
    return desc.toString();
  }

  Receipt({
    this.receiptId,
    this.receiptNo,
    this.issuedDate,
    this.customerName,
    this.category,
    this.totalAmount,
    this.fonts,
    this.customer,
    this.products,
    this.total,
    this.currency,
  });
  static String _urlEndpoint = 'http://degeitreceipt.pythonanywhere.com/v1';

  factory Receipt.fromJson(Map<String, dynamic> json) {
    ReceiptCategory convertToEnum({@required string}) {
      return ReceiptCategory.values.firstWhere((e) => e.toString() == string);
    }

    return Receipt(
      receiptId: json["id"] == null ? null : json["id"],
      receiptNo: json["receipt_number"] == null ? null : json["receipt_number"],
      issuedDate: json["date"] == null ? null : json["date"],
      customerName:
          json["customer"]["name"] == null ? null : json["customer"]["name"],
      category: json["customer"]["platform"] == null
          ? null
          : convertToEnum(string: json["customer"]["platform"]),
      totalAmount: json["total"] == null ? null : json["total"].toString(),
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      products: json["products"].isEmpty
          ? null
          : (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
    );
  }

  @override
  String toString() {
    return '$receiptId:  $receiptNo : $issuedDate : $customerName : $description : $totalAmount : ($category) : $customer : $products';
  }

  bool shouldGenReceiptNo() {
    return autoGenReceiptNo;
  }

  bool enablePreset() {
    return preset;
  }

  bool enablePaidStamp() {
    return paidStamp;
  }

  bool enableSaveCustomer() {
    return saveCustomer;
  }

  bool enablePartPayment() {
    return partPayment;
  }

  num getTotal() {
    return total;
  }

  Currency getCurrency() {
    return currency;
  }

  void toggleAutoGenReceiptNo() {
    autoGenReceiptNo = !autoGenReceiptNo;
    notifyListeners();
  }

  void togglePreset() {
    preset = !preset;
    notifyListeners();
  }

  set setPaidStamp(bool val) {
    paidStamp = val;
    notifyListeners();
  }

  void setCurrency(Currency currency) {
    this.currency = currency;
    notifyListeners();
  }

  void togglePaidStamp() {
    paidStamp = !paidStamp;
    notifyListeners();
  }

  void toggleSaveCustomer() {
    saveCustomer = !saveCustomer;
    notifyListeners();
  }

  void togglPartPayment() {
    partPayment = !partPayment;
    notifyListeners();
  }

  void toggleIssued() {
    issued = !issued;
    notifyListeners();
  }

  void setCustomer(Customer customer) {
    this.customer = customer;
  }

  void setColor({@required String hexCode}) {
    if (hexCode.isNotEmpty) {
      this.primaryColorHexCode = hexCode;
    } else {
      this.primaryColorHexCode = null;
    }
  }

  void setCategory(ReceiptCategory category) => this.category = category;

  void setProducts(List<Product> products) => this.products = products;

  void setNumber(int receiptNo) {
    this.customer != null
        ? print("theirs a customer")
        : print("no customer object good");
    receiptNo = receiptNo;
  }

  void setIssueDate(String date) {
    issuedDate = date;
  }

  void setFont(int font) {
    fonts = font;
  }

  void setSignature(String signatureImageUrl) {
    signature = signatureImageUrl;
  }

  void setReminderTime(TimeOfDay time) {
    reminderTime = time;
  }

  void setReminderDate(DateTime date) {
    reminderDate = date;
  }

  void setTotal(num total) {
    this.total = total;
  }

  convertToDateTime() {
    var d = this.reminderDate.toString();
    // var t = this.reminderTime.toString();
    return this.partPaymentDateTime = d;
  }

  Map<String, dynamic> toJson() => {
        "customer": {
          "name": customer.name,
          "email": customer.email,
          "address": customer.address,
          "platform": category.toString(),
          "phoneNumber": customer.phoneNumber,
          "saved": saveCustomer,
        },
        "receipt": {
          "date": convertToDateTime(),
          "font": fonts,
          "color": primaryColorHexCode,
          "preset": preset,
          "paid_stamp": paidStamp,
          "issued": issuedDate == null ? false : true,
          "deleted": false,
          "partPayment": partPayment,
          "partPaymentDateTime": convertToDateTime(),
          "currency": currency.toString() ?? '₦'
        },
        "products": products,
      };

  void showJson() {
    print(json.encode(toJson()));
  }

  Future updatedReceipt(String receiptId) async {
    print(receiptId);
    var uri = "$_urlEndpoint/business/receipt/draft/update";
    var token = await _sharedPreferenceService.getStringValuesSF("AUTH_TOKEN");

    var response = await http.put(uri, body: {
      'receiptId': receiptId,
    }, headers: {
      "token": token,
    });

    print(response.statusCode);
    print(json.decode(response.body));
    /*  if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Draft updated successfully',
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
      return 'Draft updated successfully';
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry something went Wrong, try again',
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
      return 'Sorry something went Wrong, try again';
    } */
  }

  saveReceipt() async {
    var uri = "$_urlEndpoint/business/receipt/customize";
    var token = await _sharedPreferenceService.getStringValuesSF("AUTH_TOKEN");

    // Hive goes here
// /////////////////////////////////////////////////////////////////////////////////////////////////////
//     final customerBox = Hive.box('customer');
//     final receiptHistoryBox = Hive.box('receiptHistory');
//     final draftBox = Hive.box('draft');
    // HiveDb hd = HiveDb();
    // if (issued == true) {
    //   hd.addCustomer(customer);
    // } else if (issued == false) {
    //   // hd.addDraft(receipt);
    // }

//////////////////////////////////////////////////////////////////////////////////////////////////////
    try {
      var response = await http.post(uri,
          body: json.encode(toJson()),
          headers: {"token": token, "Content-Type": "application/json"});

      print(token);
      print(json.encode(toJson()));
      // print('${json.decode(response.body)}');
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return "Receipt saved successfully";
      } else {
        print("failed");
        return "failed";
      }
    } catch (e) {
      throw (e);
    }
  }
  List<Receipt> _issuedReceipt = [];
  List<Receipt> get issuedReceipt => _issuedReceipt;

  filterReceipt(List<Receipt> receiptList, String value) {
    
    bool searchReceiptByCustomerName(Receipt receipt, String pattern) {
      if (receipt.customerName != null) {
        return receipt.customerName.toLowerCase().contains(value);
      }
      return false;
    }

    bool searchReceiptByDescription(Receipt receipt, String pattern) {
      if (receipt.description != null) {
        return receipt.description.toLowerCase().contains(value);
      }
      return false;
      
     
    }
   if (receiptList.isNotEmpty) {
        _issuedReceipt = receiptList
            .where((receipt) =>
                searchReceiptByCustomerName(receipt, value) ||
                searchReceiptByDescription(receipt, value))
            .toList();
      }

      notifyListeners();
    print("Receipt list : $receiptList");
  }
}

List<Receipt> dummyReceiptList = [
  Receipt(
    receiptNo: '0020',
    issuedDate: '12-05-2020',
    customerName: 'Carole Johnson',
    totalAmount: '83,000',
    category: ReceiptCategory.WHATSAPP,
  ),
  Receipt(
    receiptNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Carole Froschauer',
    totalAmount: '80,000',
    category: ReceiptCategory.WHATSAPP,
  ),
  Receipt(
    receiptNo: '0023',
    issuedDate: '21-07-2020',
    customerName: 'Paul Walker',
    totalAmount: '6,000',
    category: ReceiptCategory.INSTAGRAM,
  ),
  Receipt(
    receiptNo: '0035',
    issuedDate: '11-04-2020',
    customerName: 'Dwayne Johnson',
    totalAmount: '40,000',
    category: ReceiptCategory.INSTAGRAM,
  ),
  Receipt(
    receiptNo: '0037',
    issuedDate: '29-12-2020',
    customerName: 'Johnson Stones',
    totalAmount: '33,000',
    category: ReceiptCategory.TWITTER,
  ),
  Receipt(
    receiptNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Kelvin Hart',
    totalAmount: '44,000',
    category: ReceiptCategory.TWITTER,
  ),
];
