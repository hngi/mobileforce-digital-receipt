import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String date;
  final int
      isRead; //sqflite doesn't yet support boolean types so we have to use integers to store this data

  NotificationModel({
    @required this.id,
    @required this.title,
    @required this.message,
    @required this.date,
    @required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"] == null ? null : json["id"].toString(),
        title: json["title"] == null ? null : json["title"],
        message: json["message"] == null ? null : json["message"],
        date: json["date_to_deliver"] == null ? null : json["date_to_deliver"],
        isRead: null,
        // isRead: json["message"] == null ? null : json["isRead"] ?? null,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": this.id,
        "title": this.title,
        "message": this.message,
        "date": this.date,
        "isRead": this.isRead,
      };

  @override
  String toString() {
    return "$id : $title : $message : $isRead";
  }
}
