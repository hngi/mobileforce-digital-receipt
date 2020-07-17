import 'package:digital_receipt/screens/dashboard.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/create_receipt_step0.dart';
import 'create_receipt_page.dart';
import 'notification_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          //backgroundColor: Color(0xFF226EBE),
          ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF0B57A7)),
        child: MainDrawer(),
      ),
      body: SafeArea(
        child: DashBoard(),
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          onPressed: () async {
           /*  var connected = await Connected().checkInternet();
            if (!connected) {
              await showDialog(
                context: context,
                builder: (context) {
                  return NoInternet();
                },
              );
              return;
            } */
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateReceiptPage()));
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Color(0xFF25CCB3),
        ),
      ),
    );
  }
}
