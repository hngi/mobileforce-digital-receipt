import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

enum ReceiptCategory { WHATSAPP, INSTAGRAM, FACEBOOK, TWITTER, REDIT, OTHERS }


class Receipt extends ChangeNotifier {
  String receiptNo;
  bool autoGenReceiptNo = true;
  String issuedDate;
  String customerName;
  String description;
  ReceiptCategory category;
  String totalAmount;
  Customer customer;
  List<Product> products;
  String primaryColorHexCode;
  bool preset = false;
  bool paidStamp = false;
  bool partPayment = false;
  int fonts;
  String partPaymentDateTime;
  String signature;

  Receipt({
    this.receiptNo,
    this.issuedDate,
    this.customerName,
    this.description,
    this.category,
    this.totalAmount,
    this.fonts,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
        receiptNo:
            json["receipt_number"] == null ? null : json["receipt_number"],
        issuedDate: json["date"] == null ? null : json["date"],
        customerName:
            json["customer"]["name"] == null ? null : json["customer"]["name"],
        category: json["category"] == null ? null : json["category"],
        totalAmount: json["total"] == null ? null : json["total"].toString(),
      );

  @override
  String toString() {
    return '$receiptNo : $issuedDate : $customerName : $description : $totalAmount : ($category) : $customer : $products';
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

  
  void toggleAutoGenReceiptNo() {
    autoGenReceiptNo = !autoGenReceiptNo;
    notifyListeners();
  }
  void togglePreset() {
    preset = !preset;
    notifyListeners();
  }
  void togglePaidStamp() {
    paidStamp = !paidStamp;
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
    receiptNo = receiptNo;
  }

  void setIssueDate(String date) {
    issuedDate = date;
  }

  void setFont(int font) {
    fonts = font;
  }

  void setSignature(String signatureImageUrl){
    signature  = signatureImageUrl;
  }

         Map<String, dynamic> toJson() => {
        "customer": {
          "name": customer.name,
          "email": customer.email,
          "address": customer.address,
          "platform": category,
          "phoneNumber": customer.phoneNumber,
          // "saved": true,
        },
        "receipt": {
          "date": issuedDate == null ? DateTime.now().toString():issuedDate,
          "font": fonts,
          "color": primaryColorHexCode,
          "preset": preset,
          // "paid_stamp": customPaidStamp,
          "issued": issuedDate == null ? false : true,
          "deleted": false,
          "partPayment": partPayment
          // "partPaymentDateTime": partPayment = false ?  : DateTime.now()
        },
        "products": jsonEncode(products),
      };
}

List<Receipt> dummyReceiptList = [
  Receipt(
    receiptNo: '0020',
    issuedDate: '12-05-2020',
    customerName: 'Carole Johnson',
    description: 'Introduction to Numeritical analysis sales',
    totalAmount: '83,000',
    category: ReceiptCategory.WHATSAPP,
  ),
  Receipt(
    receiptNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Carole Froschauer',
    description: 'Cryptocurrency course, intro to after effects',
    totalAmount: '80,000',
    category: ReceiptCategory.WHATSAPP,
  ),
  Receipt(
    receiptNo: '0023',
    issuedDate: '21-07-2020',
    customerName: 'Paul Walker',
    description: 'Introduction to Programming book sales',
    totalAmount: '6,000',
    category: ReceiptCategory.INSTAGRAM,
  ),
  Receipt(
    receiptNo: '0035',
    issuedDate: '11-04-2020',
    customerName: 'Dwayne Johnson',
    description: 'Cryptocurrency course, intro to after effects',
    totalAmount: '40,000',
    category: ReceiptCategory.INSTAGRAM,
  ),
  Receipt(
    receiptNo: '0037',
    issuedDate: '29-12-2020',
    customerName: 'Johnson Stones',
    description: 'Introduction to Numeritical analysis sales',
    totalAmount: '33,000',
    category: ReceiptCategory.TWITTER,
  ),
  Receipt(
    receiptNo: '0021',
    issuedDate: '11-04-2020',
    customerName: 'Kelvin Hart',
    description: 'Cryptocurrency course, intro to after effects',
    totalAmount: '44,000',
    category: ReceiptCategory.TWITTER,
  ),
];
