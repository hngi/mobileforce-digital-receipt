import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceiptUtil {
  static List<Receipt> sortReceiptByCategory(List<Receipt> receiptList,
      {ReceiptCategory byCategory}) {
    try {
      ReceiptCategory _byCategory =
          byCategory != null ? byCategory : ReceiptCategory.WHATSAPP;
      return receiptList
          .where((element) => element.category == _byCategory)
          .toList();
    } catch (error) {
      /*  Fluttertoast.showToast(
          msg: 'error, try again ',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG); */
    }
  }

  static List<Receipt> sortReceiptByDate(List<Receipt> receiptList) {
    try {
      receiptList.sort((a, b) => a.issuedDate.compareTo(b.issuedDate));
      return receiptList.toList();
    } catch (error) {
      /*  Fluttertoast.showToast(
          msg: 'error, try again ',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG); */
    }
  }

  static List<Receipt> sortReceiptByReceiptNo(List<Receipt> receiptList) {
    try {
      receiptList.sort((a, b) => a.receiptNo.compareTo(b.receiptNo));
      return receiptList.toList();
    } catch (error) {
      /*  Fluttertoast.showToast(
          msg: 'error, try again ',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    } */
    }
  }

  static List<Receipt> filterReceipt(List<Receipt> receiptList, String value) {
    try {
      print(value);
      return receiptList
          .where((receipt) =>
              receipt.customerName
                  //.replaceAll(new RegExp(r' '), '')
                  .toLowerCase()
                  .contains(value) ||
              receipt.description
                  // .replaceAll(new RegExp(r' '), '')
                  .toLowerCase()
                  .contains(value))
          .toList();
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'error, try again ',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    }
  }
}

setReceipt({snapshot, @required context}) {
  print('color::: ${snapshot['sellerName']}');
  if (snapshot['color'] != null) {
    Provider.of<Receipt>(context, listen: false).primaryColorHexCode =
        snapshot['color'];
  } else {
    Provider.of<Receipt>(context, listen: false).primaryColorHexCode = '539C30';
  }

  if (snapshot['paid_stamp'] == true) {
    Provider.of<Receipt>(context, listen: false).setPaidStamp = true;
  }

  var prod = snapshot['products'].map((e) {
    return Product(
        id: e['id'].toString(),
        productDesc: e['name'],
        quantity: e['quantity'].toDouble(),
        unitPrice: e['unit_price'].toDouble(),
        amount: (e['quantity'] * e['unit_price']).toDouble(),
        tax: e['tax_amount'],
        discount: double.parse(e['discount']));
  });
  List<Product> products = List.from(prod);
  // print(products);
  Provider.of<Receipt>(context, listen: false)
    //   ..setNumber(56)
    ..customerName = snapshot['customer']['name']
    ..totalAmount = snapshot['total'].toString()
    ..total = snapshot['total']
    ..receiptNo = snapshot['receipt_number']
    ..receiptId = snapshot['id']
    ..sellerName = snapshot['sellerName'] ?? ''
    ..products = products
    ..signature = snapshot['signature']
    ..currency = snapshot['currency']
    ..customer = Customer(
      name: snapshot['customer']['name'],
      email: snapshot['customer']['email'],
      phoneNumber: snapshot['customer']['phoneNumber'],
      address: snapshot['customer']['address'],
    )
    ..setIssueDate(snapshot['date']);
  /* String id, String productDesc, int quantity, int amount, int unitPrice */
}

class Utils {
  static String formatNumber(double amount) {
    NumberFormat numberFormat;
    if (amount >= 1000000)
      numberFormat = new NumberFormat.compact();
    else
      numberFormat = new NumberFormat();

    return numberFormat.format(amount);
  }

  static String preferredDateFormat(DateTime dateTime,
      {bool includeTime = false}) {
    return includeTime
        ? DateFormat.yMMMEd('en_US').add_jm().format(dateTime)
        : DateFormat.yMMMEd('en_US').format(dateTime);
  }
}

Future deleteDailogs(
    {String id, String title, Future onDelete, BuildContext context}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.all(20),
          // insetPadding: EdgeInsets.all(20),
          title: Text(
            "Are sure you want to delete $title ?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 90,
                height: 48,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.blue[50],
                  child: Text(
                    'cancel',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 90,
                height: 48,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () async {
                    await onDelete;
                  },
                  color: Colors.red,
                  child: Text(
                    'delete',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
