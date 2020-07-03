import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/services/send_receipt_service.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final _qty = TextEditingController();
  final _price = TextEditingController();
  final _desc = TextEditingController();

  List<Product> proList = [];

  @override
  Widget build(BuildContext context) {
    SendReceiptService srs = Provider.of<SendReceiptService>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          height: 900,
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  RawMaterialButton(
                      padding: EdgeInsets.only(top: 70, bottom: 10, left: 10),
                      constraints: BoxConstraints.tightForFinite(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                      ))
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 9),
                        Text(
                          'Product description',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 13,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          controller: _desc,
                        ),
                        SizedBox(height: 22),
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 13,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          controller: _qty,
                          // keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 22),
                        Text(
                          'Unit price',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 13,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                        SizedBox(height: 5),
                        AppTextField(
                          controller: _price,
                          // keyboardType: TextInputType.number
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            'Product added',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.3,
                              fontSize: 14,
                              color: Color(0xFF219653),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SubmitButton(
                          title: 'Add',
                          backgroundColor: Color(0xFF0B57A7),
                          onPressed: () {
                            print("hello");
                            print(_qty.text);
                            print(_desc.text);
                            print(_price.text);
                            proList.add(Product.receipt(
                                quantity: int.parse(_qty.text),
                                productDesc: _desc.text,
                                unitPrice: int.parse(_price.text)));
                            print("new product list items");
                            print(proList);
                            print(proList[0].unitPrice);
                            srs.setProducts(proList);
                            Fluttertoast.showToast(
                                msg: 'Product added successfully',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green[600],
                                textColor: Colors.white,
                                fontSize: 16.0);
                            _qty.text = "";
                            _price.text = "";
                            _desc.text = "";
                          },
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
