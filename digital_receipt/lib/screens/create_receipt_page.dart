import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/widgets/create_receipt_step2.dart';
import 'package:digital_receipt/widgets/create_receipt_step0.dart';
import 'package:digital_receipt/widgets/create_receipt_step1.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReceiptPage extends StatefulWidget {
  const CreateReceiptPage({Key key, this.issuedCustomerReceipt})
      : super(key: key);
  final Receipt issuedCustomerReceipt;
  @override
  _CreateReceiptPageState createState() => _CreateReceiptPageState();
}

class _CreateReceiptPageState extends State<CreateReceiptPage> {
  CarouselIndex currentIndex = CarouselIndex();

  CarouselController _carouselController = CarouselController();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a Receipt',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    height: double.infinity,
                    autoPlay: false,
                    viewportFraction: 1.0,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex.setIndex(index);
                      });
                    }),
                items: [
                  CreateReceiptStep0(
                    carouselController: _carouselController,
                    carouselIndex: currentIndex,
                    issuedCustomerReceipt: widget.issuedCustomerReceipt,
                  ),
                  CreateReceiptStep1(
                    carouselController: _carouselController,
                    carouselIndex: currentIndex,
                    issuedCustomerReceipt: widget.issuedCustomerReceipt,
                  ),
                  CreateReceiptStep2(
                    carouselController: _carouselController,
                    carouselIndex: currentIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.title,
    this.amount,
    this.index,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String amount;
  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Ink(
            color: Color(0xFFEBF1F8),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.3,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          softWrap: true,
                        ),
                      ),
                      Text(
                        amount,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.3,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        index == 0 ? SizedBox(height: 5) : SizedBox.shrink(),
        index == 0
            ? Text(
                'Tap to edit. Swipe to delete',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 25),
      ],
    );
  }
}
