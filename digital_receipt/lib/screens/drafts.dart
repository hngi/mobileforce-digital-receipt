import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constant.dart';
import '../models/receipt.dart';
import '../services/api_service.dart';

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
          future: _apiService.getDraftReciepts(), // receipts from API
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Receipt receipt = snapshot.data[index];
                    DateTime date =
                        DateFormat('yyyy-mm-dd').parse(receipt.issuedDate);
                    return receiptCard(
                        receiptNo: receipt.receiptNo,
                        total: receipt.totalAmount,
                        date: "${date.day}/${date.month}/${date.year}",
                        receiptTitle: "Title",
                        subtitle: "Crptocurrency, intro to after effects");
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
            }
            // }
          }),
    );
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
