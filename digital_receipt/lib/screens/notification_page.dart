import 'package:digital_receipt/constant.dart';
// import 'package:digital_receipt/models/notification.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // int _notificationLength = 12;
  ApiService _apiService = ApiService();
  dynamic allNotification = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setNotification();
    });
  }

  void setNotification() async {
    var val = await _apiService.getAllNotifications();
    setState(() {
      allNotification = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _apiService.getAllNotifications(),
            builder: (context, snapshot) {
              // print('snamp: $snapshot');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                // print("Notification Page${snapshot.data}");
                // allNotification = snapshot.data;
                if (snapshot.hasData && snapshot.data.length != 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleNotification(
                        notificationLength: snapshot.data.length == null
                            ? 0
                            : snapshot.data.length,
                        body: '${snapshot.data[index]['message']}',
                        date: allNotification[index]['date_to_deliver'] != null
                            ? "${DateFormat('yyyy-mm-dd').format(DateTime.parse(snapshot.data[index]['date_to_deliver']))}"
                            : '',
                        index: index,
                      );
                    },
                  );
                } else {
                  return noNotificationAlert();
                }
              }
              return noNotificationAlert();
            }),
      ),
    );
  }

  Container noNotificationAlert() {
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
            child: Text("There are no notifications created!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class SingleNotification extends StatelessWidget {
  const SingleNotification({
    Key key,
    @required int notificationLength,
    this.date,
    this.body,
    this.index,
  })  : _notificationLength = notificationLength,
        super(key: key);

  final int _notificationLength;
  final String date;
  final String body;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16),
          Text(
            body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(date, style: Theme.of(context).textTheme.subtitle2),
          ),
          index != _notificationLength - 1
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Theme.of(context).disabledColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : SizedBox(
                  height: 30,
                ),
        ],
      ),
    );
  }
}
