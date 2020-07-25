import 'package:digital_receipt/widgets/app_card.dart';
import 'package:flutter/material.dart';

import 'edit_reminder_screen.dart';

/// This code displays only the UI
class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
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
        future: null, // receipts from API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      // HardCoded Receipt details
                      return GestureDetector(
                        child: reminderCard(
                          total: "80,000",
                          date: "12-06-2020",
                          reminderTitle: "Carole Froschauer",
                          subtitle: "Crptocurrency, intro to after effects ",
                          dueDate: "In 1 month time",
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
          }
          // }
        },
      ),
    );
  }

  Widget reminderCard({String total, date, reminderTitle, subtitle, dueDate}) {
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
                          Text("$subtitle",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle2),
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
