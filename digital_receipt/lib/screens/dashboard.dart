import 'dart:io';

import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/email_service.dart';
class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
      var  data ;
      var  user ;
      int deptIssued;
      var  recNo;
      double amnt;

      ApiService apiService = new ApiService();
      final SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();



    Future<Map<String,dynamic>> issuedReceiptWithToken() async {
      String token = await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      return ApiService().getIssuedReceipt(token);
    
    }
  

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: issuedReceiptWithToken(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
        if(!snapshot.hasData){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            
              Center(child: CircularProgressIndicator(backgroundColor: Color(0xFF0B57A7),)),
              SizedBox(height: 10,),
              Text('Loading Dashborad...'),
            ],
          );
        }else{

        var  data ;
        var  user ;
        var deptIssued = 0;
        double amnt = 0;
        var  recNo = snapshot.data['data'].length;

        for(var i=0; i < snapshot.data['data'].length; i++){

        data = snapshot.data['data'][i];
        user = data['user'];
        amnt += data['total'];

        if(data['partPayment']){
          deptIssued += 1;
        }
      
        } 

        return  Container(
        padding: EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Column(
          children: <Widget>[
            _buildInfo(name: user['name'], email: user['email_address'], contact: user['phoneNumber'], address: user['address']),
            SizedBox(
              height: 24.0,
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  _singleCard(
                    leading: 'No of receipts',
                    subtitle: '$recNo',
                    color: Color(0xFF25CCB3),
                  ),
                  _singleCard(
                    leading: 'Debts',
                    subtitle: '$deptIssued',
                    color: Color(0xFFE897A0),
                  ),
                  _singleCard(
                    leading: 'Total Sales',
                    subtitle: '$amnt',
                    color: Color(0xFF25CCB3),
                  ),
                  /*  FlatButton(
                    onPressed: () async {
                      print('canSend');
                      final EmailService emailService = EmailService();
                      //final bool canSend = await FlutterMailer.canSendMail();

                      //print(canSend);
                      emailService.setMail(
                        body:
                            '<h1>a long body for the email<h1> <br> with a subset of HTML',
                        subject: 'Degeit',
                        recipients: ['2amafav3@gmail.com'],
                        isHTML: true,
                        ccRecipients: [],
                        bccRecipients: [],
                        attachments: <String>[
                          '/storage/emulated/0/Download/Outliers.pdf'
                        ],
                      );
                      await emailService.sendMail();
                    },
                    child: Text('Test mail'),
                  ), */
                ],
              ),
            ),
          ],
        ),
      );
        }
      },
    );
  }

  Container _buildInfo({String name, String address, String email, String contact}) {
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
                  '$name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                 address != null ? '$address' : 'No address found',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '$email',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  contact != null ? '$contact' : 'No contact found',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
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
          )
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
              subtitle,
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
