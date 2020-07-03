import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import '../models/receipt.dart';
import 'device_info_service.dart';
import 'shared_preference_service.dart';
import 'package:http/http.dart' as http;
import 'package:digital_receipt/models/receipt.dart';

class ApiService {
  static DeviceInfoService deviceInfoService = DeviceInfoService();
  static String _urlEndpoint = "https://degeit-receipt.herokuapp.com/v1";
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 4000,
      baseUrl: _urlEndpoint,
      // headers: {"Authorization": basicAuth},
    ),
  );

  Future<String> loginUser(String email_address, String password) async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String deviceId = await deviceInfoService.getId();
    String fcmToken = await _firebaseMessaging.getToken();
    String deviceType;
    String auth_token;
    String userId;

    //Check deviceType
    if (Device.get().isAndroid) {
      deviceType = 'andriod';
    } else if (Device.get().isIos) {
      deviceType = 'ios';
    }

    try {
      print(email_address);
      print(password);
      print(fcmToken);
      print(deviceType);
      Response response = await _dio.post(
        "/user/login",
        data: {
          "password": '$password',
          "email_address": '$email_address',
          "deviceType": deviceType,
          "registration_id": fcmToken,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          // headers: {"Authorization": basicAuth},
        ),
      );

      if (response.data["status"] == 200) {
        print(response.data["status"]);

        userId = response.data["data"]["_id"];
        auth_token = response.data["data"]["auth_token"];

        //Save details to Shared Preference
        _sharedPreferenceService.addStringToSF("USER_ID", userId);
        _sharedPreferenceService.addStringToSF("AUTH_TOKEN", auth_token);
        _sharedPreferenceService.addStringToSF("EMAIL", email_address);
        //
        print(auth_token);
        print(userId);
        return "true";
      } else {
        print(response.data);
        return response.data["error"];
      }
    } on DioError catch (error) {
      print(error);
    }
  }

  Future<List<Receipt>> getDraftReciepts() async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    try {
      String auth_token =
          await _sharedPreferenceService.getStringValuesSF("AUTH_TOKEN");
      Response response = await _dio.get(
        "/business/receipt/draft",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"token": auth_token},
        ),
      );

      if (response.statusCode == 200) {
        List<Receipt> draft_receipts = [];
        response.data["data"].forEach((data) {
          Receipt receipt = Receipt.fromJson(data);
          draft_receipts.add(receipt);
        });
        return draft_receipts;
      } else {
        return null;
      }
    } on DioError catch (error) {
      print(error);
    }
  }

  Future<String> signinUser(String email, String password, String name) async {
    var uri = '$_urlEndpoint/user/register';
    var response = await http.post(
      uri,
      body: {
        "email_address": "$email",
        "password": "$password",
        "name": "$name"
      },
    );
    if (response.statusCode == 200) {
      return "true";
    }
    return response.body;
  }

  Future<bool> logOutUser(String token) async {
    var uri = '$_urlEndpoint/user/logout';

    //print(token);
    var response = await http.post(uri, headers: <String, String>{
      "token": token,
    });
    print('code: ${response.statusCode}');
    if (response.statusCode == 200) {
      //set the token to null
      _sharedPreferenceService.addStringToSF("AUTH_TOKEN", 'empty');
      print('done');

      return true;
    }
    print(response.body);
    return false;
  }

  /* Future userInfo(String email) async {
    var uri = '$_urlEndpoint/user/email/exists?email_address=$email';
    var response = await http.get(uri, body: {
      "email_address": email,
    });
    print('code: ${response.statusCode}');
    if (response.statusCode == 200) {
      //set the token to null

      return jsonDecode(response.body);
    }
    return null;
  } */

  /*  Future<bool> changePassword(String token, String email, String password) async {
    var uri = '$_urlEndpoint/user/change_password';
    var response = await http.put(
      uri,
      headers: {
        "token": token,
      },
      body: {
        'email_address': email,
        "password": password,
      }
    );
    print('code: ${response.statusCode}');
    if (response.statusCode == 200) {
      //set the token to null

      return true;
    }
    return false;
  } */

  Future<bool> updateBusinessInfo({
    String phoneNumber,
    String name,
    String address,
    String slogan,
  }) async {
    var uri = '$_urlEndpoint/business/info/update';
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    String businessId =
        await _sharedPreferenceService.getStringValuesSF('Business_ID');
    var response = await http.put(
      uri,
      headers: <String, String>{
        "token": token,
      },
      body: {
        "phoneNumber": phoneNumber,
        "name": name,
        "address": address,
        "slogan": slogan,
        "businessId": businessId,
      },
    );
    print(jsonDecode(response.body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return true;
    }
    return false;
    // return responseBody['message'] ?? responseBody['error'];
    /* } on SocketException {
      return "No network";
    }
 */
  }

  Future<bool> setUpBusiness({
    String token,
    String phoneNumber,
    String name,
    String address,
    String slogan,
    String logo,
  }) async {
    var uri = Uri.parse('$_urlEndpoint/business/info/create');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name;
    request.fields['phone_number'] = phoneNumber;
    request.fields['address'] = address;
    request.fields['slogan'] = slogan;

    request.headers['token'] = token;
    request.files.add(
      await http.MultipartFile.fromPath("logo", logo),
    );

    var response = await request.send();
    print('code: ${response.statusCode}');
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      var businessId = jsonDecode(res)['id'];
      //set the token to null
      await _sharedPreferenceService.addStringToSF('Business_ID', businessId);

      print(
          'pref: ${await _sharedPreferenceService.getStringValuesSF('Business_ID')}');
      return true;
    }
    return false;
  }

  Future<String> changePassword(
      String currentPassword, String newPassword) async {
    var uri = '$_urlEndpoint/user/change_password';
    var storedEmail = await _sharedPreferenceService.getStringValuesSF('EMAIL');
    var storedToken =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    try {
      final response = await http.put(
        uri,
        body: jsonEncode({
          "email_address": storedEmail,
          "password": newPassword,
          "current_password": currentPassword,
        }),
        headers: <String, String>{
          "token": storedToken,
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );

      var responseBody = json.decode(response.body.toString());
      print(responseBody);
      print('api post recieved!');
      if (response.statusCode == 200) {
        return "true";
      }
      return responseBody['message'] ?? responseBody['error'];
    } on SocketException {
      return "No network";
    }
  }

  Future<Map<String,dynamic>> getIssuedReceipt(String token) async {

    // String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6ImNhODM4NDQ2LTQ4YjctNDg2Zi1hMzAyLTkyNDJjZDA5NDM1NCIsIm5hbWUiOiJmcm96ZW4iLCJlbWFpbF9hZGRyZXNzIjoiZnJvemVuQGdtYWlsLmNvbSIsInBhc3N3b3JkIjoiZnJvemVuIiwicmVnaXN0cmF0aW9uX2lkIjoiNTI3MjgyNTFmd3lldGhoZ2RhIiwiZGV2aWNlVHlwZSI6ImFuZHJpb2QiLCJhY3RpdmUiOnRydWUsImlzX3ByZW1pdW1fdXNlciI6ZmFsc2UsImV4cCI6MTU5NDEzNjEzOX0.0Z_pFd5c3VbOjtfUkvMQj-oEIvpwvQqj0tCWbwbdtCY';
  String url = 'https://degeit-receipt.herokuapp.com/v1/business/receipt/issued';
   final http.Response res = await http.get(url, headers: <String, String>{
      "token": token,
    }).catchError((err) => print(err));

    if(res.statusCode == 200){
    var data = json.decode(res.body);
      return data;
    }else{
     
        print('null');
      return null;
    }
}

}


