import 'package:digital_receipt/widgets/receipt_item.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //Implement code for back action here
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[ReceiptScreenLayout()],
          ),
        ),
      ),
    );
  }
}

Widget ReceiptScreenLayout() {
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

    Container(
      // margin: EdgeInsets.fromLTRB(10,20,10,20),
      padding: EdgeInsets.all(0),
      alignment: Alignment.topCenter,
      // width: 325,
      decoration: BoxDecoration(
        color: Color(0xFFF2F8FF),
        border: Border.all(
          color: Colors.grey[500],
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Color(0xFF539C30),
                    height: 13,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(

                      //padding: const EdgeInsets.all(10),

                      child: Center(
                    child: Text(
                      'Geek Tutor',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      '2118 Thornridge Cir. Syracuse, Connecticut 35624',
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
                    height: 20,
                  ),
                  DashedSeparator(
                    color: Color(0xFFB6B6B6),
                    height: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Date: 17-06-2020',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.normal,
                              height: 1.43,
                            ),
                          ),
                        ),
                        Text(
                          'Reciept No: 10334',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.normal,
                              height: 1.43),
                        ),
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
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Email: zpopley3@nifty.com',
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
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            'Product details',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ReceiptItem(),
                  ReceiptItem(),
                  SizedBox(
                    //toatal payment and stamp

                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 1,
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.normal,
                                  height: 1.43,
                                ),
                              ),
                            ),
                            Image.asset('assets/images/paid-stamp.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                '₦80,000',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  letterSpacing: 0.03,
                                  fontWeight: FontWeight.w600,
                                  height: 1.43,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Denny',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            letterSpacing: 0.03,
                            fontFamily: 'Southampton',
                            fontWeight: FontWeight.w300,
                            height: 1.43,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 1,
                          color: Color(0xFFE3E3E3),
                          width: 107,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Signature',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            letterSpacing: 0.03,
                            fontWeight: FontWeight.w300,
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    ),

    //SIGNATURE section

    //SHARE BUTTON
    SizedBox(
      height: 45,
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
        child: Text(
          'Share',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          //take this action
        },
      ),
    ),
    SizedBox(
      height: 15,
    ),
  ]);
}

class DashedSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const DashedSeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
