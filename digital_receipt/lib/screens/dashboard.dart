import 'dart:convert';
import 'dart:io';

import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/providers/business.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import '../services/email_service.dart';
import '../utils/connected.dart';
import '../constant.dart';

final ApiService _apiService = ApiService();
final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  dynamic recNo;
  int deptIssued;
  double amnt;

  @override
  void initState() {
    callFetch();
    super.initState();
  }

  callFetch() async {
    var res = await _apiService.fetchAndSetUser();
    if (res != null) {
      // print('res:::: ${res.phone}');
      Provider.of<Business>(context, listen: false).setAccountData = res;
      var val = Provider.of<Business>(context, listen: false).toJson();
      _sharedPreferenceService.addStringToSF('BUSINESS_INFO', jsonEncode(val));
      //print('val:: $val');
    }
  }

  Future refreshPage() async {
    var connected = await Connected().checkInternet();
    if (!connected) {
      await showDialog(
        context: context,
        builder: (context) {
          return NoInternet();
        },
      );

      //return;
    } else {
      await callFetch();
      var snapshot = await _apiService.getIssuedReceipt2();
      var userData = snapshot;
      // setState(() {
      recNo = recInfo(userData)['recNo'];
      deptIssued = recInfo(userData)['dept'];
      amnt = recInfo(userData)['total'];
      // });
    }
  }

  Map<String, dynamic> recInfo(var snapshot) {
    var data;

    int snapLength = snapshot['data'].length;
    // ignore: unused_local_variable
    double amnt = 0;
    // ignore: unused_local_variable
    int deptIssued = 0;
    for (var i = 0; i < snapLength; i++) {
      data = snapshot['data'][i];
      amnt += data['total'];

      if (data['partPayment']) {
        deptIssued += 1;
      }
      //print(data['total']);
    }
    return {'total': amnt, 'recNo': snapLength, 'dept': deptIssued};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        children: <Widget>[
          _buildInfo(),
          SizedBox(
            height: 24.0,
          ),
          FutureBuilder(
            future: _apiService.getIssuedReceipt2(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasData) {
                return Expanded(
                    child: RefreshIndicator(
                  onRefresh: () async {
                    await refreshPage();
                  },
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: SizedBox(
                          height: 200,
                          child: kEmpty,
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nothing to see here. Click the plus icon to create a receipt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontSize: 16,
                            letterSpacing: 0.03,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat',
                            height: 1.43,
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    ),
                  ),
                );
              } else {
                var userData = snapshot.data;
                recNo = recInfo(userData)['recNo'];
                deptIssued = recInfo(userData)['dept'];
                amnt = recInfo(userData)['total'];
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await refreshPage();
                    },
                    child: buildGridView(recNo, deptIssued, amnt),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  GridView buildGridView(recNo, int deptIssued, double amnt) {
    RandomColor _color = RandomColor();
    return GridView.count(
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: <Widget>[
        _singleCard(
          leading: 'No of receipts',
          subtitle: '$recNo',
          color: _color.randomColor(colorBrightness: ColorBrightness.dark),
        ),
        _singleCard(
          leading: 'Debts',
          subtitle: '$deptIssued',
          color: _color.randomColor(colorBrightness: ColorBrightness.dark),
        ),
        _singleCard(
          leading: 'Total Sales',
          subtitle: '₦${Utils.formatNumber(amnt)}',
          color: _color.randomColor(colorBrightness: ColorBrightness.dark),
        ),
        FlatButton(
          onPressed: () async {
            var t = DateTime.now().timeZoneName;
            print(t);
          },
          child: Text('Test'),
        ),
      ],
    );
  }

  Container _buildInfo() {
    AccountData businessInfo = Provider.of<Business>(context).accountData;
    return Container(
      height: 130,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Color(0xFF0B57A7),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  businessInfo.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  businessInfo.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  businessInfo.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  businessInfo.phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          /* Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FaIcon(
                      FontAwesomeIcons.laptopHouse,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Geek',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: 'Tutor'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ) */
        ],
      ),
    );
  }

  Container _singleCard({String leading, String subtitle, Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 3.0),
        decoration: BoxDecoration(
          color: Color(0xFFE3EAF1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              leading,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              '$subtitle',
              textScaleFactor: leading == 'Total Sales' ? 0.7 : null,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
