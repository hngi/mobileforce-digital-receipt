import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_receipt/screens/create_receipt_page.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/product_detail.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class CreateReceiptStep1 extends StatefulWidget {
  const CreateReceiptStep1({this.carouselController, this.carouselIndex});
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;

  @override
  _CreateReceiptStep1State createState() => _CreateReceiptStep1State();
}

class _CreateReceiptStep1State extends State<CreateReceiptStep1> {
  bool _partPayment = true;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 14,
            ),
            Text(
              'Product item information',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Provide the details of the product sold',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: map<Widget>([1, 1, 2], (index, url) {
                    print(index);
                    return GestureDetector(
                      onTap: () {
                        widget.carouselController.animateToPage(index);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 2,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: widget.carouselIndex.index == index
                                    ? Color(0xFF25CCB3)
                                    : Color.fromRGBO(0, 0, 0, 0.12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                      color: Color.fromRGBO(0, 0, 0, 0.16))
                                ]),
                          ),
                          index != 2 ? SizedBox(width: 10) : SizedBox.shrink()
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => ProductDetail(),
                    backgroundColor: Colors.transparent,
                    //barrierColor: Colors.red
                  );
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add product item',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.add,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Upload .CSV file',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.file_upload,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'For bulk entry you can upload a .csv file of all your product information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Product item/s',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => ProductItem(
                title: 'After effect for dummies',
                amount: '\$50000',
              ),
              itemCount: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Part payment',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  value: _partPayment,
                  onChanged: (val) {
                    setState(() {
                      _partPayment = !_partPayment;
                    });
                  },
                ),
              ],
            ),
            _partPayment
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Set reminder for payment completion',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Date',
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
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Time',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 15,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                      SizedBox(height: 5),
                      AppTextField(),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 55,
            ),
            SubmitButton(
              onPressed: () {
                widget.carouselController.animateToPage(2);
              },
              title: 'Next',
              backgroundColor: Color(0xFF0B57A7),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
