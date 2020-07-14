import 'package:digital_receipt/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReceiptUtil {
  static List<Receipt> sortReceiptByCategory(List<Receipt> receiptList,
      {ReceiptCategory byCategory}) {
        try{
    ReceiptCategory _byCategory =
        byCategory != null ? byCategory : ReceiptCategory.WHATSAPP;
    return receiptList
        .where((element) => element.category == _byCategory)
        .toList();
          } catch (error){
      Fluttertoast.showToast(msg: 'error, try again ',backgroundColor:Colors.red,toastLength: Toast.LENGTH_LONG);
    }
  }

  static List<Receipt> sortReceiptByDate(List<Receipt> receiptList) {
    try{
    receiptList.sort((a, b) => a.issuedDate.compareTo(b.issuedDate));
    return receiptList.toList();
    } catch (error){
      Fluttertoast.showToast(msg: 'error, try again ',backgroundColor:Colors.red,toastLength: Toast.LENGTH_LONG);
    }
  }

  static List<Receipt> sortReceiptByReceiptNo(List<Receipt> receiptList) {
    try{
    receiptList.sort((a, b) => a.receiptNo.compareTo(b.receiptNo));
    return receiptList.toList();
      } catch (error){
      Fluttertoast.showToast(msg: 'error, try again ',backgroundColor:Colors.red,toastLength: Toast.LENGTH_LONG);
    }
  }

  static List<Receipt> filterReceipt(List<Receipt> receiptList, String value) {
    try{
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
          } catch (error){
      Fluttertoast.showToast(msg: 'error, try again ',backgroundColor:Colors.red,toastLength: Toast.LENGTH_LONG);
    }
  }
}
