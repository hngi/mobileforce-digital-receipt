import 'dart:math';

import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Function(Product) onSubmit;

  @override
  _ProductDetailState createState() => _ProductDetailState();
  ProductDetail({Key key, this.onSubmit}) : super(key: key);
}

class _ProductDetailState extends State<ProductDetail> {
  final productDescController = TextEditingController();
  final quantityController = TextEditingController();
  final unitPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
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
                  height: 1,
                ),
                RawMaterialButton(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
                      AppTextFieldForm(
                        controller: productDescController,
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
                      AppTextFieldForm(
                        keyboardType: TextInputType.number,
                        controller: quantityController,
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
                      AppTextFieldForm(
                        keyboardType: TextInputType.number,
                        controller: unitPriceController,
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          'Product added',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 13,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SubmitButton(
                        title: 'Add',
                        backgroundColor: Color(0xFF0B57A7),
                        onPressed: () {
                          try {
                            widget.onSubmit(
                              Product(
                                id: productDescController.text.substring(1, 4) +
                                    (Random().nextInt(99) + 10).toString(),
                                productDesc: productDescController.text,
                                quantity: int.parse(quantityController.text),
                                unitPrice: int.parse(unitPriceController.text),
                                amount: int.parse(quantityController.text) *
                                    int.parse(unitPriceController.text),
                              ),
                            );
                          } catch (e) {
                            print(e);
                          }
                          Navigator.pop(context);
                        },
                        textColor: Colors.white,
                      )
                    ],
                  ) 
                  )
                  )
            )
          ]
        )
      )
    );
        
  }

  @override
  void dispose() {
    productDescController.dispose();
    quantityController.dispose();
    unitPriceController.dispose();
    super.dispose();
  }
}
