import 'dart:math';

import 'package:digital_receipt/models/product.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Function(Product) onSubmit;
  final Product product;
  final index;

  @override
  _ProductDetailState createState() => _ProductDetailState();
  ProductDetail({Key key, this.onSubmit, this.product, this.index})
      : super(key: key);
}

class _ProductDetailState extends State<ProductDetail> {
  final productDescController = TextEditingController();
  final quantityController = TextEditingController();
  final unitPriceController = TextEditingController();
  final taxController = TextEditingController();
  final discountController = TextEditingController();

  bool productAdded = false;
  Product product;

  @override
  void initState() {
    product = widget.product;
    if (product != null) {
      productDescController.text = product.productDesc;
      quantityController.text = product.quantity.toString();
      unitPriceController.text = product.unitPrice.round().toString();
      taxController.text = product.tax.round().toString();
      discountController.text = product.discount.round().toString();
    }
    super.initState();
  }

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
                    padding: EdgeInsets.only(
                        top: 60, bottom: 20, left: 10, right: 50),
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
                          validator: (val) {
                            if (val.length < 1) {
                              return "minimum length is 1 character";
                            }
                            return "";
                          }),
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
                      SizedBox(height: 22),
                      Text(
                        'Tax',
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
                        controller: taxController,
                      ),
                      SizedBox(height: 22),
                      Text(
                        'Discount',
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
                        controller: discountController,
                      ),
                      productAdded
                          ? Center(
                              child: Text(
                                product == null
                                    ? 'Product added'
                                    : 'Product edited',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.3,
                                  fontSize: 13,
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                ),
                              ),
                            )
                          : SizedBox(),
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
                                quantity: double.parse(quantityController.text),
                                unitPrice:
                                    double.parse(unitPriceController.text),
                                amount: (double.parse(quantityController.text) *
                                        double.parse(
                                            unitPriceController.text)) +
                                    (double.parse(taxController.text)) -
                                    (double.parse(discountController.text) /
                                        100 *
                                        (double.parse(quantityController.text) *
                                            double.parse(
                                                unitPriceController.text))),
                                tax: double.parse(taxController.text),
                                discount: double.parse(discountController.text),
                              ),
                            );
                            setState(() {
                              productAdded = true;
                              productDescController..text = "";
                              quantityController..text = "";
                              unitPriceController..text = "";
                              taxController..text = "";
                              discountController..text = "";
                            });
                            Future.delayed(Duration(seconds: 1), () {
                              setState(() {
                                productAdded = false;
                                product = null;
                              });
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
