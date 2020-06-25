import 'package:flutter/material.dart';

import 'sql_database_client.dart';

import 'package:digital_receipt/models/notification.dart';

class SqlDbRepository {
  final SqlDbClient sqlDbClient;

  SqlDbRepository({@required this.sqlDbClient});

  /// This function takes no paramters and creates the database
  Future createDatabase() async {
    return sqlDbClient.createDatabase();
  }
  
  /// This function takes no parameters and returns a Future of List<Notification>
  Future<List<NotificationModel>> fetchAllNotifications() async {
    return sqlDbClient.fetchAllNotifications();
  }
  
  /// This function takes a parameter of type Notification and returns a 
  /// Future of int which is the id of the notification added
  Future<int> insertNotification(NotificationModel notification) async {
    return sqlDbClient.insertNotification(notification);
  }
}