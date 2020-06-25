import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _notificationLength = 12;
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
        child: ListView.builder(
          itemCount: _notificationLength,
          itemBuilder: (BuildContext context, int index) {
            return SingleNotification(
              notificationLength: _notificationLength,
              body:
                  'You are using an outdated version of reepcy. Update to get our latest features.',
              date: '5 mins ago',
              index: index,
            );
          },
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
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
