import 'package:digital_receipt/models/product.dart';
import 'package:flutter/material.dart';

class SendReceiptService extends ChangeNotifier {
// Customer form details
  String cName;
  String cEmail;
  String cPhone;
  String cAddress;
  bool saveCustomer;
  String cPlatform;
// Product form Details
  List<Product> product;
   bool partPayment;
  DateTime partPaymentDateTime;
// Customization field
  String customFont;
  String customColor;
  bool customPaidStamp;
  bool customIssued = true;
  bool customDeleted = false;
  bool customPreset;
  Color colorVal;
  bool autoGenId = false;

  SendReceiptService(
      {this.cAddress,
      this.cName,
      this.cEmail,
      this.cPhone,
      this.cPlatform,
      this.customColor,
      this.customFont,
      this.customPaidStamp,
      this.customIssued,
      this.customDeleted,
      this.customPreset,
      this.colorVal,
      this.saveCustomer = false,
      print(product)});

  void setProducts(List<Product> product) {
    this.product = product;
    print("from provider");
    print(product);
  }

  void setCustomers(String cName, String cEmail, String cPhone, String cAddress,
      bool saveCustomer, String cPlatforrm) {
    this.cPhone = cPhone;
    this.cAddress = cAddress;
    this.saveCustomer = saveCustomer;
    this.cName = cName;
    this.cPlatform = cPlatform;
    if (saveCustomer = true) {
      print('saved customers');
      print(saveCustomer);
      print("$cPhone, $cAddress  ,$cName,  $cEmail,$cPlatform");
    } else {
      print("No saved");
    }
  }

  void setCustomization(
    String font,
    String color,
    Color colorVal,
    bool paidStamp,
    bool preset,
    bool autoGenId,
    String customNo,
  ) {
    print("Printing cusomization");
    print(font);
    print(color);
    print(colorVal);
    print(paidStamp);
    print(preset);
    print(autoGenId);
    print(customNo);
  }


  void setReminder(bool partPayment, DateTime date, DateTime time){
    this.partPayment = partPayment;
    
  }

       Map<String, dynamic> toJson() => {
        "customer": {
          "name": cName,
          "email": cEmail,
          "address": cAddress,
          "platform": cPlatform,
          "phoneNumber": cPhone,
          "saved": saveCustomer,
        },
        "receipt": {
          "date": DateTime.now().toString(),
          "font": customFont,
          "color": customColor,
          "preset": customPreset,
          "paid_stamp": customPaidStamp,
          "issued": customIssued,
          "deleted": customDeleted,
          // "partPayment":
          // "partPaymentDateTime":
        },
        "products": product
      };
}
