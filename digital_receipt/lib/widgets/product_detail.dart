import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
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
                      AppTextField(),
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
                        keyboardType: TextInputType.number,
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
                        keyboardType: TextInputType.number,
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
                        onPressed: () {},
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
