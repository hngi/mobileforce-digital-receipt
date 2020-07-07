import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';

import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/notification.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'device_info_service.dart';
import 'shared_preference_service.dart';
import 'package:http/http.dart' as http;
import '../models/account.dart';

import '../models/receipt.dart';
import 'package:digital_receipt/models/receipt.dart';

class ApiService {
  static DeviceInfoService deviceInfoService = DeviceInfoService();
  static String _urlEndpoint = "https://hng-degeit-receipt.herokuapp.com/v1";
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService();

  /* This is the user id of the logged in user. Please replace it with the userID that is returned
    from the response when the user logs in. Thank you
  */
  //String userID = "82c4e6bc-8923-4511-8b74-e85c05b34dff";

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
        // userID = userId;
        auth_token = response.data["data"]["auth_token"];

        //Save details to Shared Preference
        _sharedPreferenceService.addStringToSF("USER_ID", userId);
        _sharedPreferenceService.addStringToSF("AUTH_TOKEN", auth_token);
        _sharedPreferenceService.addStringToSF("EMAIL", email_address);
        //
        print("token :");
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
    print(response.body);
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
      _sharedPreferenceService.addStringToSF("USER_ID", null);
      _sharedPreferenceService.addStringToSF('BUSINESS_INFO', null);
      print('done');

      return true;
    }
    print(response.body);
    return false;
  }

  Future updateBusinessInfo({
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
    print(token);

    print(
      """
      name: $name,
      number: $phoneNumber,
      address: $address,
      slogan: $slogan
      """,
    );

    try {
      var response = await http.put(
        uri,
        headers: <String, String>{
          "token": token,
          // HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.acceptHeader: 'application/json',
        },
        body: {
          "phoneNumber": phoneNumber,
          "name": name,
          "address": address,
          "slogan": slogan,
          "businessId": businessId,
        },
      );
      print(response.statusCode);
      //print(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      throw (e);
    }
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

  Future changeLogo(String logo) async {
    var uri = Uri.parse('$_urlEndpoint/business/info/update');
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    String businessId =
        await _sharedPreferenceService.getStringValuesSF('Business_ID');
    print(businessId);

    var request = http.MultipartRequest('PUT', uri);

    print(logo);

    request.headers['token'] = token;
    request.fields['businessId'] = businessId;
    request.files.add(
      await http.MultipartFile.fromPath("logo", logo),
    );

    var response = await request.send();
    print('code: ${response.statusCode}');
    var res = await response.stream.bytesToString();
    print(res);
    if (response.statusCode == 200) {
      return res;
    }
    return null;
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

  //Fetch users from db;
  Future<AccountData> fetchAndSetUser() async {
    var url = "$_urlEndpoint/business/info/all";

    String token = await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

    String userID = await _sharedPreferenceService.getStringValuesSF('USER_ID');

    var email = await _sharedPreferenceService.getStringValuesSF('EMAIL');

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
        url,
        headers: <String, String>{
          'token': token,
        },
      );
      print(userID);
      print(jsonDecode(response.body)['data']);

      dynamic res = jsonDecode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        res = res.firstWhere(
          (e) => e['user'] == userID,
          orElse: () {
            print('object');
          },
        );
        print('res: $res');
        if (res != null) {
          return AccountData(
            id: res['id'],
            name: res['name'],
            phone: res['phone_number'],
            address: res['address'],
            slogan: res['slogan'],
            logo: 'https://hng-degeit-receipt.herokuapp.com${res['logo']}',
            email: email,
          );
        }
        return null;
      } else {
        var result =
            await _sharedPreferenceService.getStringValuesSF('BUSINESS_INFO');
        var res = jsonDecode(result);
        return AccountData(
          id: res['id'],
          name: res['name'],
          phone: res['phone_number'],
          address: res['address'],
          slogan: res['slogan'],
          logo: 'https://degeit-receipt.herokuapp.com${res['logo']}',
          email: email,
        );
      }
    } else {
      return null;
    }
  }

  Future<String> otpVerification(
    String email,
    password,
    name,
  ) async {
    var uri = '$_urlEndpoint/user/otp_register';
    var response = await http.post(
      uri,
      body: {"email_address": "$email"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return 'error';
  }

  Future getIssuedReceipts() async {
    var uri = "$_urlEndpoint/business/receipt/issued";
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    var connectivityResult = await (Connectivity().checkConnectivity());
    List<Receipt> _issuedReceipts = [];

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
        Uri.encodeFull(uri),
        headers: <String, String>{
          'token': token,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        data["data"].forEach((receipt) {
          _issuedReceipts.add(Receipt.fromJson(receipt));
          // Receipt.fromJson(receipt).toString();
        });
        // print(_issuedReceipts);
        return _issuedReceipts;
      } else {
        print("Issued Receipt status code ${response.statusCode}");
        return [];
      }
    }
    return [];
  }

  /// Returns a list of notifications
  /// if there are no notifications it returns an empty list
  Future<List<NotificationModel>> getAllNotifications() async {
    var uri = "$_urlEndpoint/user/notification/all";
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    print(token);
    var connectivityResult = await (Connectivity().checkConnectivity());
    List<NotificationModel> _allNotifications = [];
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
        Uri.encodeFull(uri),
        headers: <String, String>{
          'token': token,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data["data"].forEach((notification) {
          _allNotifications.add(NotificationModel.fromJson(notification));
          // NotificationModel.fromJson(notification).toString();
        });
        // print(data);
        return _allNotifications;
      } else {
        print("All notifications status code ${response.statusCode}");
        return [];
      }
    }
    return [];
  }

  Future getAllCustomers() async {
    var uri = "$_urlEndpoint/customer/all";
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

    var connectivityResult = await (Connectivity().checkConnectivity());
    List<Customer> _allCustomers = [];

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
        Uri.encodeFull(uri),
        headers: <String, String>{
          'token': token,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        //print(data);
        /*   data["data"].forEach((customer) {
          _allCustomers.add(Customer.fromJson(customer));
          Customer.fromJson(customer).toString();
        }); */
        print(data['data']);
        return data['data'];
      } else {
        print("All Customers status code ${response.statusCode}");
        return [];
      }
    }
    return [];
  }

    Future<Map<String,dynamic>> getIssuedReceipt2() async {
    String token = await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    var connectivityResult = await (Connectivity().checkConnectivity());
    String url = '$_urlEndpoint/business/receipt/issued';
    if (connectivityResult == ConnectivityResult.mobile ||
    connectivityResult == ConnectivityResult.wifi) {
    final http.Response res = await http.get(url, headers: <String, String>{
        "token": token,
      }).catchError((err) => print(err));
    
      if(res.statusCode == 200){
      var data = json.decode(res.body);
        print(data);
        return data;
      }else{
      
        return null;
      }
    }
    return null;
  }
}
