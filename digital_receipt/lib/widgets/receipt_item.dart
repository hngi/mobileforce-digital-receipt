import 'package:digital_receipt/screens/receipt_screen.dart';
import 'package:flutter/material.dart';

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 5),
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
                          fontWeight: FontWeight.normal,
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
            children: <Widget>[
              Expanded(
                //flex: 3,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(23, 0, 0, 10),
                  child: Text(
                    'After effects for dummies course',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                child: Text('₦50,000'),
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
              Expanded(
                  child: Container(
                padding: const EdgeInsets.fromLTRB(23, 0, 8, 0),
                child: Text(
                  'Qty',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.normal,
                      height: 1.43),
                ),
              )),
              Container(
                child: Text(
                  'Total',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.normal,
                      height: 1.43),
                ),
              ),
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
                    fontWeight: FontWeight.normal,
                    height: 1.43,
                  ),
                ),
              )),
              Container(
                child: Text(
                  '₦50,000',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 0.03,
                    fontWeight: FontWeight.normal,
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
  }
}
