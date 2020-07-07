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
        // backgroundColor: Color(0xff226EBE),
        /* leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), */
        title: Text(
          "Reminders",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            letterSpacing: 0.03,
          ),
        ),
        //centerTitle: true,
        //actions: <Widget>[],
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
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff539C30),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
              color: Color(0xffE8F1FB),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$reminderTitle",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.87),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                            letterSpacing: 0.03,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$subtitle",
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
                    Text(
                      "$date",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
                      TextSpan(
                        text: '$dueDate',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
                      TextSpan(
                        text: 'N$total ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          letterSpacing: 0.03,
                        ),
                      ),
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
