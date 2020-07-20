import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/providers/business.dart';
import 'package:digital_receipt/screens/generate_pdf.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:digital_receipt/widgets/receipt_item.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../constant.dart';
import 'package:intl/intl.dart';

class ReceiptScreenFromCustomer1 extends StatefulWidget {
  const ReceiptScreenFromCustomer1({
    Key key,
  }) : super(key: key);

  @override
  _ReceiptScreenFromCustomer1State createState() =>
      _ReceiptScreenFromCustomer1State();
}

GlobalKey _globalKey = new GlobalKey();

class _ReceiptScreenFromCustomer1State
    extends State<ReceiptScreenFromCustomer1> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ApiService _apiService = ApiService();
    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
      appBar: AppBar(
        //  backgroundColor: Color(0xFF0b56a7),
        automaticallyImplyLeading: true,
        title: Text(
          'Create Receipt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ReceiptScreenLayout(context, _loading, () {
                setState(() {
                  _loading = true;
                });
              }, () {
                setState(() {
                  _loading = false;
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ReceiptScreenLayout(
    [BuildContext context,
    bool loading,
    Function loadingStart,
    Function loadingStop]) {
  return Column(children: <Widget>[
    SizedBox(
      height: 14,
    ),
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'All Done, share!',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    SizedBox(
      height: 24,
    ),

    //Main part of the receipt page

    RepaintBoundary(
      key: _globalKey,
      child: Container(
        // margin: EdgeInsets.fromLTRB(10,20,10,20),
        padding: EdgeInsets.all(0),
        alignment: Alignment.topCenter,
        // width: 325,
        decoration: BoxDecoration(
          //  color: Color(int.parse("0xFF"+Provider.of<Receipt>(context,listen: false).primaryColorHexCode)),
          border: Border.all(
            color: Colors.grey[500],
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 15),
            Image.asset("assets/logos/Group 53.png", scale: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          "2118 Thornridge Cir, Syracuse, Connecticut 35624",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              letterSpacing: 0.03,
                              height: 1.43),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          'Tel No: (603) 555-0123',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.03,
                              height: 1.43),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          'Email: cfroschauerc@ucoz.ru',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.normal,
                              height: 1.43),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text(
                                'Customer Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Name: Denys Wilacot',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    letterSpacing: 0.03,
                                    fontWeight: FontWeight.normal,
                                    height: 1.43),
                              ),
                            ),
                            Text(
                              'Phone No: 741-142-4459',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.normal,
                                  height: 1.43),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10.0, left: 10.0),
                        child: Container(
                          color: Color(0xFFE9F5E7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TriangleSeparator(angle: 180),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Receipt No : 10334',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        letterSpacing: 0.03,
                                        fontWeight: FontWeight.normal,
                                        height: 1.43),
                                  ),
                                  Container(
                                    child: Text(
                                      "Date: 17-06-2020",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        letterSpacing: 0.03,
                                        fontWeight: FontWeight.normal,
                                        height: 1.43,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 25, bottom: 10),
                                child: Text(
                                  'Product details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Divider(),
                              ReceiptItemDummy(),
                              TriangleSeparator()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        //toatal payment and stamp
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 50,
                              top: 20,
                            ),
                            child: SizedBox(
                              height: 65,
                              width: 65,
                              child: kPaidStamp("539C30".toLowerCase()),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Subotal: ₦80,000',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        letterSpacing: 0.03,
                                        fontWeight: FontWeight.w600,
                                        height: 1.43,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Discount: 5%',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        letterSpacing: 0.03,
                                        fontWeight: FontWeight.normal,
                                        height: 1.43,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Tax: 2%',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        letterSpacing: 0.03,
                                        fontWeight: FontWeight.normal,
                                        height: 1.43,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Total: ₦77,520',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.bold,
                              height: 1.43,
                            ),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Signature: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                letterSpacing: 0.03,
                                fontWeight: FontWeight.w300,
                                height: 1.43,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Text(
                                "jamesvardy",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  letterSpacing: 0.03,
                                  fontFamily: 'Southampton',
                                  fontWeight: FontWeight.w300,
                                  height: 1.43,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    ),

    //SIGNATURE section

    //SHARE BUTTON
    SizedBox(
      height: 5,
    ),
   
    SizedBox(
      height: 15,
    ),
    SizedBox(
      width: double.infinity,
      height: 45,
      child: FlatButton(
        //padding: EdgeInsets.all(5.0),
        color: Color(0xFF0b56a7),
        textTheme: ButtonTextTheme.primary,
        //minWidth: 350,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: loading == false
            ? Text(
                'Share',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            : ButtonLoadingIndicator(
                color: Colors.white, height: 20, width: 20),
        onPressed: () async {},
      ),
    ),
    SizedBox(
      height: 15,
    ),
  ]);
}

class TriangleSeparator extends StatelessWidget {
  final double height;
  final int angle;

  const TriangleSeparator({this.height = 1, this.angle = 0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return Transform.rotate(
              angle: angle * (math.pi / 180),
              child:
                  CustomPaint(size: Size(10, 10), painter: DrawTriangleShape()),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  Paint painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = Color(0xFFD6D6D6)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ReceiptItemDummy extends StatelessWidget {
  const ReceiptItemDummy({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                letterSpacing: 0.03,
                                fontWeight: FontWeight.bold,
                                height: 1.43),
                          ),
                        ),
                        Text(
                          'Description',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.normal,
                              height: 1.43),
                        ),
                      ],
                    ),
                    Text(
                      'Unit Price',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          letterSpacing: 0.03,
                          fontWeight: FontWeight.normal,
                          height: 1.43),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      //flex: 3,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 10),
                        child: Text("After effects for dummies \ncourse",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: Text("₦50,000",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),

              //quantity of products order and the total price (HEADER)

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(23, 0, 8, 0),
                      child: Text(
                        'Qty',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.fromLTRB(23, 0, 8, 0),
                      child: Text(
                        'X 1',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 0.03,
                          fontWeight: FontWeight.bold,
                          height: 1.43,
                        ),
                      ),
                    )),
                    Container(
                      child: Text(
                        "₦50,000",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 0.03,
                          fontWeight: FontWeight.bold,
                          height: 1.43,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        });
  }
}
