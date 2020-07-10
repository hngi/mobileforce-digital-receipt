import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/receipt.dart';
import '../services/api_service.dart';
import 'receipt_page_customer.dart';

/// This code displays only the UI
class Drafts extends StatefulWidget {
  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  ApiService _apiService = ApiService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Drafts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
        actions: <Widget>[],
      ),
      body: FutureBuilder(
          future: _apiService.getDraft(), // receipts from API
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              print('sbap:: {snapshot.data.length}');
              return ListView.builder(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Receipt receipt = Receipt.fromJson(snapshot.data[index]);
                  DateTime date =
                      DateFormat('yyyy-mm-dd').parse(receipt.issuedDate);
                  return GestureDetector(
                    onTap: () {
                      setReceipt(snapshot.data[index]);
                      print(Provider.of<Receipt>(context, listen: false));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ReceiptScreenFromCustomer()));
                    },
                    child: receiptCard(
                        receiptNo: receipt.receiptNo,
                        total: receipt.totalAmount,
                        date: "${date.day}/${date.month}/${date.year}",
                        receiptTitle: receipt.customerName,
                        subtitle: "Crptocurrency, intro to after effects"),
                  );
                },
              );
            } else {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: kBrokenHeart,
                      height: 170,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "There are no draft receipts created!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          letterSpacing: 0.3,
                          color: Color.fromRGBO(0, 0, 0, 0.87),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
              // Center(
              //   child: Text("There are no draft receipts created",
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold, fontSize: 16.0)),
              // );
            }

            // }
          }),
    );
  }

  setReceipt(snapshot) {
    print('color::: ${snapshot['color']}');
    if (snapshot['color'] != null) {
      Provider.of<Receipt>(context, listen: false).primaryColorHexCode =
          snapshot['color'];
    } else {
      Provider.of<Receipt>(context, listen: false).primaryColorHexCode =
          '539C30';
    }

    if (snapshot['paid_stamp'] == true) {
      Provider.of<Receipt>(context, listen: false).setPaidStamp = true;
    }

    var prod = snapshot['products'].map((e) {
      return Product(
        id: e['id'].toString(),
        productDesc: e['name'],
        quantity: e['quantity'],
        unitPrice: e['unit_price'].toDouble(),
        amount: (e['quantity'] * e['unit_price']).toInt(),
      );
    });
    List<Product> products = List.from(prod);
    // print(products);
    Provider.of<Receipt>(context, listen: false)
      //   ..setNumber(56)
      ..customerName = snapshot['customer']['name']
      ..totalAmount = snapshot['total'].toString()
      ..total = snapshot['total']
      ..receiptNo = snapshot['receipt_number']
      ..receiptId = snapshot['id']
      ..products = products
      ..customer = Customer(
        name: snapshot['customer']['name'],
        email: snapshot['customer']['email'],
        phoneNumber: snapshot['customer']['phoneNumber'],
        address: snapshot['customer']['address'],
      )
      ..setIssueDate(snapshot['date']);
    /* String id, String productDesc, int quantity, int amount, int unitPrice */
  }

  Widget receiptCard({String receiptNo, total, date, receiptTitle, subtitle}) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff539C30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Color(0xffE8F1FB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Receipt No: $receiptNo",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.03,
                          ),
                        ),
                        Text(
                          "$date",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Text(
                      "$receiptTitle",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 102.0, 5.0),
                    child: Text(
                      "$subtitle",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        height: 1.43,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    // )
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Total: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Montserrat',
                                letterSpacing: 0.3,
                              ),
                            ),
                            TextSpan(
                              text: ' N$total ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                                letterSpacing: 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
