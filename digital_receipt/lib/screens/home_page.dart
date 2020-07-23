import 'package:digital_receipt/screens/dashboard.dart';
import 'package:digital_receipt/screens/no_internet_connection.dart';
import 'package:digital_receipt/screens/second_screen.dart';
import 'package:digital_receipt/services/notification.dart';
import 'package:digital_receipt/services/shared_preference_service.dart';
import 'package:digital_receipt/utils/connected.dart';
import 'package:digital_receipt/widgets/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'create_receipt_page.dart';

AppNotification appNotification = AppNotification();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    super.initState();
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondScreen(receivedNotification.payload),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen(payload)),
      );
    });
  }

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
            print(await SharedPreferenceService()
                .getStringValuesSF('AUTH_TOKEN'));
            // await appNotification.showNotificationWithNoSound();
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
