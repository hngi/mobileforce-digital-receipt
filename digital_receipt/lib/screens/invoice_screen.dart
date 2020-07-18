import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0B57A7),
        title: Text(
          'Create an Invoice',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[InvoiceScreenLayout()],
          ),
        ),
      ),
    );
  }
}

Widget InvoiceScreenLayout() {
  return Column(
    children: <Widget>[
      Container(
        color: Color(0xFFF2F8FF),
        child: Text(
          'Invoice is ready!',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        alignment: FractionalOffset(0.05, 0.05),
      ),
      SizedBox(height: 24),
      //Main part of the receipt page
      Container(
        padding: EdgeInsets.all(0),
        alignment: Alignment.topCenter,
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
                    children: <Widget>[
                      //Colored blue section
                      Container(
                        color: Color(0xFF0B57A7),
                        height: 10,
                        width: double.infinity,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Geek Tutor',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '2118 Thornridge Cir. Syracuse',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Tel No: (603) 555-0123',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Email: cfroschauerc@ucoz.ru',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: const DashedSeparator(color: Colors.grey),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Date: 18-07-2020'),
                            SizedBox(height: 5),
                            Text('Due Date: 28-07-2020'),
                            SizedBox(height: 5),
                            Text('Invoice No: 10334'),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Text(
                                'Customer Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Name: Denys Wilacot'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Email: zpopley3@nifty.com'),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Phone No: 741-142-4459'),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 8),
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

                      //List of products and quantities
                      Container(
                        //product details title
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              3, 0, 8, 0),
                                          child: Text('1'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text('Description'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('Unit Price'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //First product on the list bought or purchased

                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Text(
                                                'After effects for dummies course'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('₦50,000'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //quantity of products order and the total price (HEADER)
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 16, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Text('Qty'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('Total'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Text('X 1'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('₦50,000'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      //SECOND PRODUCT ORDER LIST

                      //List of products and quantities
                      Container(
                        //product details title
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              3, 0, 8, 0),
                                          child: Text('2'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Text('Description'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('Unit Price'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Text('Crytotrading course'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('₦30,000'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //quantity of products order and the total price (HEADER)
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 16, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Text('Qty'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('Total'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //quantiy of purchased products and total price

                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Text('X 1'),
                                          ),
                                        ),
                                        Container(
                                          child: Text('₦30,000'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),

                      Container(
                        //toatal payment and stamp
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Total'),
                                        Spacer(),
                                        Container(
                                          child: Text('₦80,000'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.0),

                                  //Bank Account details for payment section
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      'Account details for payment',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    padding:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Bank'),
                                        Spacer(),
                                        Container(
                                          child: Text('UBA'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Text('Account no.:'),
                                        Spacer(),
                                        Container(
                                          child: Text('2342903174'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //SHARE BUTTON
      SizedBox(
        height: 55,
      ),
      SizedBox(
        width: double.infinity,
        height: 45,
        child: FlatButton(
          onPressed: () {},
          color: Color(0xFF0b56a7),
          textTheme: ButtonTextTheme.primary,
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
        ),
      ),
    ],
  );
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
