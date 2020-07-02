import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum ReceiptCategory { WHATSAPP, INSTAGRAM, FACEBOOK, TWITTER, OTHERS }

class Receipt extends ChangeNotifier {
  String receiptNo;
  String issuedDate;
  String customerName;
  String description;
  ReceiptCategory category;
  String totalAmount;
  Customer customer;
  List<Product> products;

  Receipt({
    this.receiptNo,
    this.issuedDate,
    this.customerName,
    this.description,
    this.category,
    this.totalAmount,
  });

  @override
  String toString() {
    return '$receiptNo : $issuedDate : $customerName : $description : $totalAmount : ($category) : $customer : $products';
  }

  void setCustomer(Customer customer) {
    this.customer = customer;
  }

  void setCategory(ReceiptCategory category) => this.category = category;

  void setProducts(List<Product> products) => this.products = products;

  void setNumber(int receiptNo) {receiptNo = receiptNo;}

  void setIssueDate(String date) {issuedDate = date;}
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
