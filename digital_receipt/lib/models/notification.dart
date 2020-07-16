import 'package:flutter/material.dart';

class NotificationModel{
  final String id;
  final String title;
  final String body;
  final String date;
  final int isRead; //sqflite doesn't yet support boolean types so we have to use integers to store this data

  NotificationModel({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.date,
    @required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        date: json["date"] == null ? null : json["date"],
        isRead: json["body"] == null ? null : json["isRead"],
        
    );

    Map<String, dynamic> toJson() => <String, dynamic>{
        "id": this.id,
        "title": this.title,
        "body": this.body,
        "date": this.date,
        "isRead": this.isRead,
        
    };
  
}

