import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../widgets/delete_dialog.dart';
import '../constant.dart';
import '../models/receipt.dart';
import '../services/api_service.dart';
import '../services/shared_preference_service.dart';
import 'receipt_page_customer.dart';

final numberFormat = new NumberFormat();
final dateFormat = DateFormat('dd-MM-yyyy');

class Drafts extends StatefulWidget {
  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  ApiService _apiService = ApiService();
  var draftData;
  String currency = '';
  Future draftFuture;

  setCurrency() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
  }

  setDraft() async {
    draftFuture = _apiService.getDraft();
    var res = await draftFuture;
    setState(() {
      draftData = res;
    });
  }

  @override
  void initState() {
    setCurrency();
    setDraft();
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
      body: RefreshIndicator(
        onRefresh: () async {
          refreshDraft() async {
            draftFuture = _apiService.getDraft();
            var val = await draftFuture;
            setState(() {
              draftData = val;
            });
            print(draftData);
          }

          var connected = await Connected().checkInternet();
          if (!connected) {
            await showDialog(
              context: context,
              builder: (context) {
                return NoInternet();
              },
            );
          } else {
            await refreshDraft();
          }

          // setState(() {
          //refreshDraft();
          // });
        },
        child: FutureBuilder(
            future: draftFuture, // receipts from API
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                //print('sbap:: {snapshot.data.length}');
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  itemCount: draftData.length,
                  itemBuilder: (context, index) {
                    Receipt receipt = Receipt.fromJson(draftData[index]);
                    return Dismissible(
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteDialog(
                                title:
                                    'Are you sure you wish to delete this item?',
                                onDelete: () async {
                                  Navigator.of(context).pop(true);
                                  String response = await _apiService
                                      .deleteDraft(id: receipt.receiptId);
                                  if (response == 'true') {
                                    setState(() {
                                      draftData.removeAt(index);
                                    });
                                    Fluttertoast.showToast(
                                      msg: 'Draft deleted successfully',
                                      fontSize: 12,
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.red,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Sorry an error occured try again',
                                      fontSize: 12,
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        key: Key(receipt.receiptId),
                        child: _buildReceiptCard(receipt, index, setDraft));
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
                          style: Theme.of(context).textTheme.headline6,
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
      ),
    );
  }

  Widget _buildReceiptCard(Receipt receipt, index, dynamic onDone) {
    return GestureDetector(
      onTap: () async {
        setReceipt(snapshot: draftData[index], context: context);
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ReceiptScreenFromCustomer()));
        await onDone();
      },
      child: Column(
        children: <Widget>[
          AppCard(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Receipt No: ${receipt.receiptNo}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      Text(
                        dateFormat.format(DateTime.parse(receipt.issuedDate)),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    receipt.customerName,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      receipt?.products?.first?.productDesc ?? '',
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Total:\t\t $currency${numberFormat.format(double.parse(receipt.totalAmount))}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget receiptCard(
      {String receiptNo,
      total,
      date,
      receiptTitle,
      subtitle,
      Currency currency}) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xff539C30),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Color(0xffE8F1FB),
                borderRadius: BorderRadius.circular(5),
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
                              text:
                                  '${Utils.formatNumber(double.parse(total))}',
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
