import 'dart:math' as math;
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/widgets/button_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constant.dart';


class ReceiptScreenFromCustomer2 extends StatefulWidget {
  const ReceiptScreenFromCustomer2({
    Key key,
  }) : super(key: key);

  @override
  _ReceiptScreenFromCustomer2State createState() =>
      _ReceiptScreenFromCustomer2State();
}

GlobalKey _globalKey = new GlobalKey();

class _ReceiptScreenFromCustomer2State
    extends State<ReceiptScreenFromCustomer2> {
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

        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 15),
                  Image.asset("assets/logos/Group 53.png", scale: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
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
                                "Thanks for your order",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    letterSpacing: 0.03,
                                    height: 1.43),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                color: Color(0xFF18610B),
                                height: 60.0,
                                width: double.infinity,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: CustomPaint(
                                        painter: CustomCurvePainter1(),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'TOTAL',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  letterSpacing: 0.03,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.43,
                                                ),
                                              ),
                                              Text(
                                                ' ₦ 77,520',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  letterSpacing: 0.03,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.43,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
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
                                    SizedBox(height: 10.0),
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
                                      padding:
                                          EdgeInsets.only(top: 25, bottom: 10),
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
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
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
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
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
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
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
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
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
                                        padding: const EdgeInsets.only(
                                          bottom: 25.0,
                                        ),
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
                                  )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Total: ₦77,520',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 0.03,
                                        fontWeight: FontWeight.bold,
                                        height: 1.43,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                color: Color(0xFF18610B),
                                height: 130.0,
                                width: double.infinity,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: CustomPaint(
                                        painter: CustomCurvePainter2(),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                "2118 Thornridge Cir, Syracuse, Connecticut 35624",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    letterSpacing: 0.03,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1.43),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 2.7,
              left: MediaQuery.of(context).size.width / 4,
              child: SizedBox(
                height: 55,
                width: 55,
                child: kPaidStamp("539C30".toLowerCase()),
              ),
            )
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

class CustomCurvePainter2 extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFF216C13);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.6,
        size.width * 0.04, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.9,
        size.width * 0.4, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.3,
        size.width * 0.6, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 0.85, size.width * 0.7, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomCurvePainter1 extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFF216C13);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.7, 0);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.6,
        size.width * 0.7, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.6, size.height, size.width * 0.65, size.height * 0.99);
    path.quadraticBezierTo(
        size.width * 0.9, size.height * 0.6, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    // path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
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
