import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/screens/receipt_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptItem extends StatelessWidget {
  const ReceiptItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Provider.of<Receipt>(context, listen: false).products.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 200,
            child: Column(
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
                            Provider.of<Receipt>(context, listen: false)
                                .products[index]
                                .productDesc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Text(Provider.of<Receipt>(context, listen: false)
                            .products[index]
                            .unitPrice
                            .toString()),
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
                          Provider.of<Receipt>(context, listen: false)
                              .products[index]
                              .quantity
                              .toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              letterSpacing: 0.03,
                              fontWeight: FontWeight.normal,
                              height: 1.43),
                        ),
                      )),
               
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
                          '=',
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
                          '₦'+Provider.of<Receipt>(context, listen: false)
                              .products[index]
                              .amount
                              .toString(),
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
            ),
          );
        });
  }
}
