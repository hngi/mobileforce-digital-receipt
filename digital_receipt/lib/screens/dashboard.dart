import 'dart:async';
import 'dart:convert';
import 'setup.dart';
import 'package:digital_receipt/models/account.dart';
import 'package:digital_receipt/providers/business.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/check_login.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import '../utils/connected.dart';
import '../constant.dart';
import 'login_screen.dart';

final ApiService _apiService = ApiService();
final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();
StreamSubscription<dynamic> subscription;

Stream isLoggedStream;
CheckLogin checkLogin = CheckLogin();
Future<Map<String, dynamic>> dashboardFuture;

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  dynamic recNo;
  int deptIssued;
  double amnt;

  var promoWidth = 0.0;
  var promoHeight = 0.0;
  var promotionData;
  String currency = '';

  @override
  void initState() {
    dashboardFuture = _apiService.getIssuedReceipt2();
    callFetch();
    setCurrency();
    isLogin(context);
    super.initState();
  }

  setCurrency() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
  }

  isLogin(BuildContext context) {
    dynamic value = '';

    if (subscription == null) {
      subscription = Stream.periodic(Duration(seconds: 1)).listen((eve) async {
        var event = await checkLogin.isLoggedIn();
        //print(event);
        if (value != event) {
          print('event');
          print('value');
          await Future.microtask(() => value = event);

          if (value == false) {
            await _sharedPreferenceService.addStringToSF("AUTH_TOKEN", 'empty');
            await _sharedPreferenceService.addStringToSF(
                "REGISTRATION_ID", null);

            await FirebaseMessaging().setAutoInitEnabled(true);
            await FirebaseMessaging().deleteInstanceID();

            if (mounted) {
              await Navigator
                  .pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LogInScreen()),
                      (route) => false).then((value) => Fluttertoast.showToast(
                    msg: 'You need to log in to continue',
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.grey[700],
                    textColor: Colors.white,
                  ));
            }
          }
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (subscription != null) {
      subscription.cancel();
      print('PAUSE: ${subscription.isPaused}');
      subscription = null;
      super.deactivate();
    }
    isLogin(context);

    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print('dispose');
    if (subscription != null) {
      subscription.cancel();
      subscription = null;
      super.deactivate();
    }
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
      subscription = null;
      super.deactivate();
    }

    super.dispose();
  }

  callFetch() async {
    print('in');
    var business = Provider.of<Business>(context, listen: false);
    var res = await _apiService.fetchAndSetUser();
    //print(res);
    if (res != null) {
      // print('res:::: ${res.phone}');
      business.setAccountData = res;
      var val = business.toJson();
      _sharedPreferenceService.addStringToSF('BUSINESS_INFO', jsonEncode(val));
      //print('val:: $val');
    } else if (res == null) {
      print(res);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Setup()),
          (route) => false);
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

      dashboardFuture = _apiService.getIssuedReceipt2();
      var snapshot = await dashboardFuture;
      setState(() {
        var userData = snapshot;

        recNo = recInfo(userData)['recNo'];
        deptIssued = recInfo(userData)['dept'];
        amnt = recInfo(userData)['total'];
      });
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
            future: dashboardFuture,
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
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 0.0, bottom: 15),
                              child: FutureBuilder(
                                future: _apiService.getPromotion(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  print("snapshot data for dashboard");
                                  print(snapshot.data);
                                  if (snapshot.hasData) {
                                    return GestureDetector(
                                      onTap: () {
                                        Fluttertoast.showToast(
                                            msg: "app updated");
                                      },
                                      child: Container(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    snapshot.data['imageUrl']),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ),
                          buildGridView(recNo, deptIssued, amnt),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
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
    Color _getRandomColor() {
      return _color.randomColor(colorBrightness: ColorBrightness.dark);
    }

    return GridView.count(
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      children: <Widget>[
        _singleCard(
          leading: 'No of receipts',
          subtitle: '$recNo',
          color: _getRandomColor(),
        ),
        _singleCard(
          leading: 'Debts',
          subtitle: '$deptIssued',
          color: _getRandomColor(),
        ),
        _singleCard(
          leading: 'Total Sales',
          subtitle: '$currency${Utils.formatNumber(amnt)}',
          color: _getRandomColor(),
        ),
       /*  FlatButton(
          onPressed: () async {
            //var t = DateTime.now().timeZoneName;
            print(await SharedPreferenceService()
                .getStringValuesSF('AUTH_TOKEN'));
          },
          child: Text('Test'),
        ), */
      ],
    );
  }

  Container _buildInfo() {
    AccountData businessInfo = Provider.of<Business>(context).accountData;
    return Container(
      height: 130,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyText1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    businessInfo.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    businessInfo.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    businessInfo.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    businessInfo.phone,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Card(
        margin: EdgeInsets.only(left: 5.0),
        shape: kRoundedRectangleBorder,
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
