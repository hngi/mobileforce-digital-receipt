import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/notification.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // int _notificationLength = 12;
  ApiService _apiService = ApiService();
  List<NotificationModel> allNotification = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setNotification();
    });
  }

  void setNotification() async {
    allNotification = await _apiService.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 16,
            //color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<NotificationModel>>(
            future: _apiService.getAllNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                print("Notification Page${snapshot.data}");
                allNotification = snapshot.data;
                if (snapshot.hasData && snapshot.data.length != 0) {
                  return ListView.builder(
                    itemCount:
                        allNotification == null ? 0 : allNotification.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleNotification(
                        notificationLength: allNotification.length,
                        body: '${allNotification[index].message}',
                        date: '${allNotification[index].date}',
                        index: index,
                      );
                    },
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
                            "There are no notifications created!",
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
              }
            }),
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
            style: TextStyle(
              fontSize: 16,
              height: 1.43,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.03,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              date,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w200,
                letterSpacing: 0.03,
                color: Colors.black,
              ),
            ),
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
                      color: Color(0xFFC8C8C8),
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
