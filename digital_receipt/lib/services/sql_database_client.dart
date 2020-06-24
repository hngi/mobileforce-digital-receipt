import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:digital_receipt/models/notification.dart';

class SqlDbClient {
  Database _database;
  NotificationModel notification;

  /// This function takes no paramters and creates the database
  Future createDatabase() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbpath = join(path.path, 'digital_receipt.db');
    _database = await openDatabase(dbpath, version: 1, onCreate: this._create);
  }

  /// This function takes two parameters, one of type Database and another of type int and creates the notifications database
  Future _create(Database _database, int version) async {
    await _database.execute("""
    CREATE TABLE notifications(id TEXT,title TEXT,body TEXT,date TEXT,isRead NUMBER);
    """);
  }

  /// This function takes no parameters and returns a Future of List<Notification>
  Future<List<NotificationModel>> fetchAllNotifications() async {
    List<Map> query = await _database.query("notifications", orderBy: "date");
    List<NotificationModel> notifications = List();
    query.forEach((s) {
      NotificationModel notification = NotificationModel.fromJson(s);
      notifications.add(notification);
    });
    return notifications;
  }

  /// This function takes a parameter of type Notification and returns a 
  /// Future of int which is the id of the notification added
  Future<int> insertNotification(NotificationModel notification) async {
    int id;

    List<Map> query = await _database.query("notifications", orderBy: "date");
    List<NotificationModel> notifications = List();
    query.forEach((s) {
      NotificationModel notification = NotificationModel.fromJson(s);
      notifications.add(notification);
    });

    if (notifications.length == 100) {
      
      // delete the oldest notification and insert the latest notification to
      //make the notification 100 in number

      await _database.rawDelete(
          'DELETE FROM notifications WHERE id = ?', [notifications.first.id]);

      id = await _database.insert("notifications", notification.toJson());
      print("                                                                                     ");
      print("                                                                                     ");
      print("                                                                                     ");
      print("Flutter is inserting notification in Shared Preference with id $id and details: ${notification.toJson()}");
      print("                                                                                     ");
      print("                                                                                     ");
      print("                                                                                     ");

    } else {
      
      // Just insert the notification since we have not reached the 100th mark
      id = await _database.insert("notifications", notification.toJson());
      print("                                                                                     ");
      print("                                                                                     ");
      print("                                                                                     ");
      print("Flutter is inserting notification in Shared Preference with id $id and details: ${notification.toJson()}");
      print("                                                                                     ");
      print("                                                                                     ");
      print("                                                                                     ");
    }

    return id;
  }
}
