import 'package:flutter/material.dart';

/// This code displays only the UI
class Drafts extends StatefulWidget {
  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        //backgroundColor: Color(0xff226EBE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
        future: null, // receipts from API
        builder: (context, snapshot) {
          // If the API returns nothing it means the user has to upgrade to premium
          // for now it doesn't validate if the user has upgraded to premium
          /// If the API returns nothing it shows the dialog box `JUST FOR TESTING`
          ///
          /// Uncomment the if statement
          // if (!snapshot.hasData) {
          //   return _showAlertDialog();
          // }
          // else {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  // HardCoded Receipt details
                  return receiptCard(
                      receiptNo: "0021",
                      total: "80,000",
                      date: "12-06-2020",
                      receiptTitle: "Carole",
                      subtitle: "Crptocurrency, intro to after effects");
                },
              ),
            );
          }
          // }
        },
      ),
    );
  }

  Widget receiptCard({String receiptNo, total, date, receiptTitle, subtitle}) {
    return Column(
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
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
    );
  }
}
