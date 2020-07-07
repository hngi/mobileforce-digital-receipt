import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

Future<Customer> fetchCustomer() async {
  final response = await http.get(
    'https://documenter.getpostman.com/view/6370926/T17CEquu?version=latest',
    headers: {HttpHeaders.authorizationHeader: " eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImIxYTVlMmNlLTMwZWEtNDA1ZC05MGNlLTRiZjkzNDgyYWQ4OCIsIm5hbWUiOiJmcm96ZW4iLCJlbWFpbF9hZGRyZXNzIjoiZnJvemVuQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoicGJrZGYyX3NoYTI1NiQxODAwMDAkWGE5SUR4VW9vcVFBJEpydXQ4cWhqWVJ2aU5wY0Y1cnNpWVV3MDN3c3REYm42T0ZjNzF0VTg4ZXM9IiwicmVnaXN0cmF0aW9uX2lkIjpudWxsLCJkZXZpY2VUeXBlIjpudWxsLCJhY3RpdmUiOmZhbHNlLCJpc19wcmVtaXVtX3VzZXIiOmZhbHNlLCJleHAiOjE1OTQ2MjI0ODR9.gvLbti67_P9e_aT5BlOCLBuKKBSxt6z0ivi5XahgN_U"},
  );

  if(response.statusCode == 200) {

    final responseJson = json.decode(response.body);
    return Customer.fromJson(responseJson);

  }
  else {
    throw Exception('Failed to fetch data');
  }

}


class Customer {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  Customer({
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json["name"],
    email: json['email'],
    phoneNumber: json["phoneNumber"],
    address: json['address'],
  );



}


