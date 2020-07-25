import 'package:digital_receipt/screens/receipt_page_customer.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_card.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/receipt_util.dart';
import 'package:intl/intl.dart';
import '../services/shared_preference_service.dart';
import 'package:provider/provider.dart';
import '../constant.dart';

final numberFormat = new NumberFormat();
final dateFormat = DateFormat('dd-MM-yyyy');
String currency = '';

/// This code displays only the UI
class ReceiptHistory extends StatefulWidget {
  @override
  _ReceiptHistoryState createState() => _ReceiptHistoryState();
}

class _ReceiptHistoryState extends State<ReceiptHistory> {
  TextEditingController _controller = TextEditingController();
  String dropdownValue = "Receipt No";
  bool _showDialog = false;
  //instead of dummyReceiptList use the future data gotten
  List<Receipt> receiptList = [];

  // the below is needed so as to create a copy of the list,
  //for sorting and searching functionalities
  List<Receipt> copyReceiptList = [];
  List<Receipt> recieptListData = [];
  ApiService _apiService = ApiService();

  Future receiptFuture;

  /* setSort() async {
    try {
      var res = await _apiService.getIssued();
      setState(() {
        recieptListData = res;
        receiptList = ReceiptUtil.sortReceiptByReceiptNo(recieptListData);
        copyReceiptList = receiptList;
      });
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'error, try again ',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG);
    }
  } */

  setReceiptHistory() async {
    var res = await receiptFuture;
    setState(() {
      receiptList = res;

      recieptListData = ReceiptUtil.sortReceiptByReceiptNo(receiptList);
      copyReceiptList = receiptList;
    });
  }

  setCurrency() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
  }

  @override
  void initState() {
    setCurrency();
    receiptFuture = _apiService.getIssued();
    setReceiptHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _issuedReceiptModel = Provider.of<Receipt>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Receipt History",
        ),
        //centerTitle: true,
        actions: <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            AppTextFormField(
              controller: _controller,
              hintText: "Type a keyword",
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).disabledColor,
                ),
                onPressed: () {
                  setState(() {
                    _issuedReceiptModel.filterReceipt(
                        recieptListData, _controller.text);
                    recieptListData = _issuedReceiptModel.issuedReceipt;
                  });
                },
              ),
              onChanged: (value) async {
                await Future.delayed(Duration(milliseconds: 700));
                setState(() {
                  _issuedReceiptModel.filterReceipt(
                      recieptListData, _controller.text);
                  receiptList = _issuedReceiptModel.issuedReceipt;
                });
              },
            ),
            SizedBox(height: 30.0),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text("Sort By"),
              ),
              Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color(0xff25CCB3),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownValue,
                    underline: Divider(),
                    items: <String>[
                      "Receipt No",
                      "Date issued",
                      "WhatsApp",
                      "Facebook",
                      "Instagram",
                      "Twitter",
                    ].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              value,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String value) {
                      setState(() {
                        dropdownValue = value;
                        switch (value) {
                          case "Date issued":
                            setState(() {
                              recieptListData =
                                  ReceiptUtil.sortReceiptByDate(receiptList);
                            });
                            break;
                          case "WhatsApp":
                            setState(() {
                              recieptListData =
                                  ReceiptUtil.sortReceiptByCategory(receiptList,
                                      byCategory: ReceiptCategory.WHATSAPP);
                            });
                            break;
                          case "Facebook":
                            setState(() {
                              recieptListData =
                                  ReceiptUtil.sortReceiptByCategory(receiptList,
                                      byCategory: ReceiptCategory.FACEBOOK);
                            });
                            break;
                          case "Instagram":
                            setState(() {
                              recieptListData =
                                  ReceiptUtil.sortReceiptByCategory(receiptList,
                                      byCategory: ReceiptCategory.INSTAGRAM);
                            });
                            break;
                          case "Twitter":
                            setState(() {
                              recieptListData =
                                  ReceiptUtil.sortReceiptByCategory(receiptList,
                                      byCategory: ReceiptCategory.TWITTER);
                              print(receiptList);
                            });
                            break;
                          default:
                            setState(() {
                              recieptListData =
                                  ReceiptUtil.sortReceiptByReceiptNo(
                                      receiptList);
                            });

                            break;
                        }
                      });
                    },
                  ),
                ),
              ),
            ]),
            Expanded(
              child: FutureBuilder(
                initialData: <Receipt>[],
                future: receiptFuture, // receipts from API
                builder: (context, snapshot) {
                  //print(snapshot.data[5]);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return _showDialog
                        ? _showAlertDialog()
                        : Column(
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              recieptListData.length != 0
                                  ? Flexible(
                                      child: ListView.builder(
                                        itemCount: recieptListData.length,
                                        itemBuilder: (context, index) {
                                          // HardCoded Receipt details
                                          return _buildReceiptCard(
                                              recieptListData[index], index);
                                        },
                                      ),
                                    )
                                  : Flexible(child: kEmpty),
                            ],
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
                              "There are no issued receipts created!",
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
                  }
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptCard(Receipt receipt, index) {
    return GestureDetector(
      onTap: () async {
        var snapshot = await _apiService.getIssuedReceipt2();
        print(snapshot);
        setReceipt(context: context, snapshot: snapshot['data'][index]);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReceiptScreenFromCustomer(
              receipt: receipt,
              from: 'receipt_history',
            ),
          ),
        );
        // print(receipt.products[0].amount);
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
                      receipt.products.first.productDesc,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Total:\t\t$currency${numberFormat.format(double.parse(receipt.totalAmount))}',
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

  Widget _showAlertDialog() {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Color(0xFFF2F8FF),
      contentPadding: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      content: Stack(
        children: <Widget>[
          // Flexible(
          //   child:
          Image.asset(
            "assets/BACKGROUND.jpg",
            // height: 350,
            width: 300,
            fit: BoxFit.cover,
          ),
          // ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                    top: 130.0,
                  ),
                  child: Text(
                    "Oops, i'm sure you really",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "needed that?",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Upgrade to premium",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "now to enjoy amazing",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "features",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.03,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    color: Color(0xFF0B57A7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      setState(() {
                        _showDialog = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Upgrade",
                        style: TextStyle(
                          color: Color(0xffE5E5E5),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        // color: Color(0xffE5E5E5),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
