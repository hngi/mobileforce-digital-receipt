import 'package:digital_receipt/widgets/app_card.dart';
import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/reminder.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:flutter/material.dart';

import 'edit_reminder_screen.dart';

/// This code displays only the UI
class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text(
          "Reminders",
        ),
      ),
      body: FutureBuilder(
        future: _apiService.getReminders(), // receipts from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data.length > 0) {
            return Column(
              children: <Widget>[
                //SizedBox(height: 20.0),
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16,
                      bottom: 16.0,
                      top: 30,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // HardCoded Receipt details
                      Reminder reminder = snapshot.data[index];
                      return GestureDetector(
                        child: reminderCard(
                          total:
                              "${reminder.total.toString()}", //at the moment the api does not return a balance
                          date:
                              "${Utils.preferredDateFormat(reminder.createdAt)}",
                          reminderTitle:
                              "${reminder.customerName}", //at the moment the api does not return customer details
                          receiptNumber: "${reminder.receiptNumber}",
                          dueDate:
                              "${Utils.preferredDateFormat(reminder.partPaymentDateTime, includeTime: true)}",
                        ),
                        onTap: () {
                          print('object');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditReminderScreen()));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  kBrokenHeart,
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "You don't have any reminder!",
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
        },
      ),
    );
  }

  Widget reminderCard(
      {String total, date, reminderTitle, receiptNumber, dueDate}) {
    return Column(
      children: <Widget>[
        AppCard(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("$reminderTitle",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                  )),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Receipt Number: $receiptNumber",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              height: 1.43,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("$date",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 12,
                            )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                RichText(
                  //textAlign: TextAlign.right,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Due Date: ',
                          style: Theme.of(context).textTheme.subtitle2),
                      TextSpan(
                        text: '$dueDate',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                RichText(
                  // textAlign: TextAlign.right,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Balance: ',
                          style: Theme.of(context).textTheme.subtitle2),
                      TextSpan(
                          text: 'N$total ',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
