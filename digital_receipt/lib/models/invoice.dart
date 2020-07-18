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

class Invoice extends ChangeNotifier{
  String invoiceNo;
  bool autoGenInvoiceNo = true;
  String issuedDate;
  String customerName;
  String description;
  String invoiceId;
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

  Invoice({
    this.invoiceId,
    this.invoiceNo,
    this.issuedDate,
    this.customerName,
    this.totalAmount,
    this.fonts,
    this.customer,
    this.products,
    this.total,
    this.currency,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {

    return Invoice(
      invoiceId: json["id"] == null ? null : json["id"],
      invoiceNo: json["receipt_number"] == null ? null : json["receipt_number"],
      issuedDate: json["date"] == null ? null : json["date"],
      customerName:
      json["customer"]["name"] == null ? null : json["customer"]["name"],
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
    return '$invoiceId:  $invoiceNo : $issuedDate : $customerName : $description : $totalAmount : $customer : $products';
  }

  bool shouldGenInvoiceNo() {
    return autoGenInvoiceNo;
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

  void toggleAutoGenInvoiceNo() {
    autoGenInvoiceNo = !autoGenInvoiceNo;
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

  void togglePartPayment() {
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

  void setProducts(List<Product> products) => this.products = products;

  void setNumber(int receiptNo) {
    this.customer != null
        ? print("theirs a customer")
        : print("no customer object good");
    invoiceNo = invoiceNo;
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
    },
    "products": products,
  };

  void showJson() {
    print(json.encode(toJson()));
  }


}

List<Invoice> dummyReceiptList = [
  Invoice(
    invoiceNo: '0020',
    issuedDate: '12-05-2020',
    customerName: 'Carole Johnson',
    totalAmount: '83,000',
  ),
  Invoice(
    invoiceNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Carole Froschauer',
    totalAmount: '80,000',
  ),
  Invoice(
    invoiceNo: '0023',
    issuedDate: '21-07-2020',
    customerName: 'Paul Walker',
    totalAmount: '6,000',
  ),
  Invoice(
    invoiceNo: '0035',
    issuedDate: '11-04-2020',
    customerName: 'Dwayne Johnson',
    totalAmount: '40,000',
  ),
  Invoice(
    invoiceNo: '0037',
    issuedDate: '29-12-2020',
    customerName: 'Johnson Stones',
    totalAmount: '33,000',
  ),
  Invoice(
    invoiceNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Kelvin Hart',
    totalAmount: '44,000',
  ),
];