import 'dart:convert';
import 'dart:ffi';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:digital_receipt/screens/change_password_screen.dart';
import 'package:digital_receipt/screens/edit_account_information.dart';
import 'package:digital_receipt/screens/upgrade_screen.dart';
import "package:flutter/material.dart";
import 'dart:async';
import '../providers/business.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';
import '../services/shared_preference_service.dart';
import '../models/account.dart';
import 'login_screen.dart';

final SharedPreferenceService _sharedPreferenceService =
    SharedPreferenceService();

final ApiService _apiService = ApiService();

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // static const String iapId = 'android.test.purchaseed';
  // String _platformVersion = 'Unknown';
  // List<IAPItem> _items = [];
  // List<PurchasedItem> _purchases = [];
  

  final String username = "Geek Tutor";
  String label;
  bool _loading = false;
  String localLogo = '';
  static String loading_text = "loading ...";
  var x = AccountData(
      id: loading_text,
      name: loading_text,
      phone: loading_text,
      address: loading_text,
      slogan: loading_text,
      logo: '',
      email: loading_text);

  String image;

  final picker = ImagePicker();

  AccountData _accountData;

  Future getImage() async {
    var internet = await Connected().checkInternet();
    if (!internet) {
      await showDialog(
        context: context,
        builder: (context) {
          return NoInternet();
        },
      );
      return;
    }
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = pickedFile.path;
      });
      var res = await _apiService.changeLogo(pickedFile.path);
      var logo = await SharedPreferenceService().getStringValuesSF('LOGO');

      setState(() {
        localLogo = logo;
      });
      print(res);
    }
  }

  callFetch() async {
    var res = await _apiService.fetchAndSetUser();
    var logo = await SharedPreferenceService().getStringValuesSF('LOGO');

    setState(() {
      localLogo = logo;
    });
    if (res != null) {
      Provider.of<Business>(context, listen: false).setAccountData = res;
      var val = Provider.of<Business>(context, listen: false).toJson();
      _sharedPreferenceService.addStringToSF('BUSINESS_INFO', jsonEncode(val));

      var logo = await SharedPreferenceService().getStringValuesSF('LOGO');

      setState(() {
        localLogo = logo;
      });
      print(val);
    }
  }

  @override
  void initState() {
    callFetch();
    // initPlatformState();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, bottom: 116, right: 16, top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
////////////////////////////////
              ///please do no delete this comment #Francis
/////////////////////////////////////////////
              // Center(
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => UpgradeScreen()));
              //     },
              //     child: Container(
              //       height: 133,
              //       width: double.infinity,
              //       padding: EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: Color(0xFF76DBC9)
              //           /*  gradient: LinearGradient(
              //             colors: [Colors.teal[100], Colors.teal[300]],
              //             begin: Alignment.topRight,
              //             end: Alignment.bottomLeft,
              //           ) */
              //           ),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: <Widget>[
              //               Text(
              //                 'Unlock Amazing Features',
              //                 style: CustomText.displayn,
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 'Upgrade to premium',
              //                 style: CustomText.display1,
              //               )
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
////////////////////////////////
              ///please do no delete this comment #Francis
/////////////////////////////////////////////
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: 50,
                      constraints: BoxConstraints(
                        maxWidth: 74,
                      ),
                      //width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: localLogo != null && localLogo != ''
                          ? Image.file(File(localLogo))
                          : Icon(Icons.person),
                    ),
                    onTap: () async {
                      await getImage();
                    },
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(color: Color(0xFFE7ECF1)),
                    child: InkWell(
                        onTap: () async {
                          await getImage();
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 12,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  Provider.of<Business>(context).accountData.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2, 10, 20, 10),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Color(0xFF0B57A7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditAccountInfoScreen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 4,
              ),
              Column(
                children: <Widget>[
                  InformationData(
                    label: 'Email Address',
                    detail: Provider.of<Business>(context).accountData.email,
                  ),
                ],
              ),
              InformationData(
                label: 'Phone No',
                detail: Provider.of<Business>(context).accountData.phone,
              ),
              InformationData(
                label: 'Address',
                detail: Provider.of<Business>(context).accountData.address,
              ),
              InformationData(
                label: 'Bussiness Slogan',
                detail: Provider.of<Business>(context).accountData.slogan,
              ),
              SizedBox(
                height: 35,
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Change Password',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
              SizedBox(
                height: 47,
              ),
              /* _loading
                  ? Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      ),
                    )
                  : SizedBox.shrink(), */
              FlatButton(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });
                  var internet = await Connected().checkInternet();
                  if (!internet) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return NoInternet();
                      },
                    );
                    setState(() {
                      _loading = false;
                    });
                    return;
                  }
                  String token = await _sharedPreferenceService
                      .getStringValuesSF('AUTH_TOKEN');
                  // print('token: $token');
                  if (token != null) {
                    var res = await _apiService.logOutUser(token);
                    print(res);
                    if (res == true) {
                      // print('logged out');
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => LogInScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Sorry an error occured plaese try again',
                        fontSize: 12,
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red,
                      );
                    }
                  }
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        child: _loading
                            ? Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              )
                            : Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.exit_to_app,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationData extends StatelessWidget {
  final String label;
  final String detail;

  InformationData({this.label, this.detail});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              '$label : ',
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Text(
                '$detail',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 1,
          color: Theme.of(context).disabledColor,
        ),
      ],
    );
  }
}
