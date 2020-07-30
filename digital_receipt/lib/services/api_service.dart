import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/models/notification.dart';
import 'package:digital_receipt/models/reminder.dart';
import 'package:digital_receipt/utils/connected.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'device_info_service.dart';
import 'shared_preference_service.dart';
import 'package:http/http.dart' as http;
import '../models/account.dart';

import '../models/receipt.dart';
import 'package:digital_receipt/models/receipt.dart';
import './hiveDb.dart';

final HiveDb hiveDb = HiveDb();

class ApiService {
  static DeviceInfoService deviceInfoService = DeviceInfoService();
  static String _urlEndpoint = kReleaseMode
      ? "http://degeitreceipt.pythonanywhere.com/v1"
      : "http://degeittest.pythonanywhere.com/v1";
  // http://degeittest.pythonanywhere.com/v1
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
    await _sharedPreferenceService.addStringToSF("REGISTRATION_ID", null);
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
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
        //print(email_address);
        //print(password);
        //print(fcmToken);
        //print(deviceType);

        print('''
        
            "password": '$password',
            "email_address": '$email_address',
            "deviceType": $deviceType,
            "registration_id": $fcmToken,
          
        ''');
        Response response = await _dio.post(
          "/user/login/",
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
        // print(fcmToken);

        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          print(response.data["status"]);

          userId = response.data["user"]["id"].toString();
          // print('fef $userId');
          // userID = userId;
          auth_token = response.data["token"];

          //Save details to Shared Preference
          await _sharedPreferenceService.addStringToSF("USER_ID", userId);
          await _sharedPreferenceService.addStringToSF(
              "REGISTRATION_ID", fcmToken);
          await _sharedPreferenceService.addStringToSF(
              "AUTH_TOKEN", auth_token);
          await _sharedPreferenceService.addStringToSF("EMAIL", email_address);
          //
          //print("token :");
          //print(auth_token);
          //print(userId);
          return "true";
        } else {
          //print(response.data);
          return response.data["error"];
        }
      } on DioError catch (error) {
        //print(error);
      }
    } else {
      return Future.error('No network Connection');
    }
  }

  Future<List<Receipt>> getDraftReciepts() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
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
    } else {
      return Future.error('No network Connection');
    }
  }

  Future getDraft() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      String token =
          await _sharedPreferenceService.getStringValuesSF("AUTH_TOKEN");
      Response response = await _dio
          .get(
        "/business/receipt/draft",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"token": token},
        ),
      )
          .timeout(Duration(seconds: 8), onTimeout: () {
        return null;
      });
      // print('bty: ${response.data}');
      if (response.statusCode == 200) {
        var res = response.data["data"] as List;
        //print('res:::::: $res');

        // checks if the length of draft is larger than 100 and checks for internet
        if (res.length >= 100 && connectivityResult) {
          List temp = res.getRange(0, 99).toList();
          await hiveDb.addDraft(temp);

          // return hiveDb.getDraft();
          return res;
        } else if (res.length < 100 && connectivityResult) {
          await hiveDb.addDraft(res);

          return hiveDb.getDraft();
          //return res;
        } else {
          print('res: 9');
          return hiveDb.getDraft();
        }
      } else {
        return null;
      }
    } else {
      return hiveDb.getDraft() ?? null;
    }
  }

  /// This function gets all issued receipts from the database.
  Future getIssued() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      String auth_token =
          await _sharedPreferenceService.getStringValuesSF("AUTH_TOKEN");
      Response response = await _dio.get(
        "/business/receipt/issued",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "token": auth_token,
          },
        ),
      );

      if (response.statusCode == 200) {
        //print(response.data["data"][14]);
        var res = response.data["data"];
        if (res.length >= 100) {
          List temp = response.data["data"].getRange(0, 99).toList();
          await hiveDb.addReceiptHistory(temp);

          res = res.map((e) {
            Receipt temp = Receipt.fromJson(e);
            return temp;
          });
          return List<Receipt>.from(res);
        } else if (response.data["data"].length < 100) {
          await hiveDb.addReceiptHistory(response.data["data"]);

          return hiveDb.getReceiptHistory();
        } else {
          return hiveDb.getReceiptHistory();
        }

        //return issued_receipts;
      } else {
        return null;
      }
    } else {
      return hiveDb.getReceiptHistory();
    }
  }

  Future<String> signinUser(String email, String password, String name) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/user/register/';
      var response = await http.post(
        uri,
        body: {"email": "$email", "password": "$password", "username": "$name"},
      );
      print(uri);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return "true";
      }
      return response.body;
    } else {
      return Future.error('No Network');
    }
  }

  Future<bool> logOutUser(String token) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/user/logout';

      //print(token);
      var response = await http.post(uri, headers: <String, String>{
        "token": token,
      });
      print('code: ${response.statusCode}');
      print(response.body);
      if (response.statusCode == 200) {
        //set the token to null
        _sharedPreferenceService.addStringToSF("AUTH_TOKEN", 'empty');
        _sharedPreferenceService.addStringToSF("USER_ID", null);
        _sharedPreferenceService.addStringToSF('BUSINESS_INFO', null);
        _sharedPreferenceService.addStringToSF("REGISTRATION_ID", null);
        _sharedPreferenceService.addStringToSF("ISSUER_SIGNATURE", null);
        print('done');

        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future updateBusinessInfo({
    String phoneNumber,
    String name,
    String address,
    String slogan,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/info/update';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      String businessId =
          await _sharedPreferenceService.getStringValuesSF('Business_ID');
      print(businessId);

      print(
        """
      name: $name,
      phone_number: $phoneNumber,
      address: $address,
      slogan: $slogan
      """,
      );

      try {
        var response = await http.put(
          uri,
          headers: <String, String>{
            "token": token,
          },
          body: {
            "phone_number": phoneNumber,
            "name": name,
            "address": address,
            "slogan": slogan,
            "businessId": businessId,
          },
        );
        print(jsonDecode(response.body));
        //print(response.body);
        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        return null;
      } catch (e) {
        throw (e);
      }
    } else {
      return null;
    }
  }

  Future sendPDF(String email, String receipt, String subject) async {
    var uri = Uri.parse('$_urlEndpoint/user/sendemail/pdf');
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

    var request = http.MultipartRequest('POST', uri)
      ..headers['token'] = token
      ..fields['email_address'] = email
      ..fields['subject'] = subject
      ..files.add(
        await http.MultipartFile.fromPath("receipt", receipt),
      );

    var response = await request.send();
    print('code: ${response.statusCode}');
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
      Fluttertoast.showToast(
        msg: 'Business information has been updated',
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
      return res;
    } else {
      var res = await response.stream.bytesToString();

      Fluttertoast.showToast(
        msg: 'Sorry something went Wrong, try again',
        fontSize: 12,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
      );
      return null;
    }
  }

  Future updateSignature(String signature) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/info/update';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      String businessId =
          await _sharedPreferenceService.getStringValuesSF('Business_ID');
      print(businessId);

      print(
        """
     signature: $signature
      """,
      );

      try {
        var response = await http.put(
          uri,
          headers: <String, String>{
            "token": token,
          },
          body: {
            "signature": signature,
            "businessId": businessId,
          },
        );
        print(jsonDecode(response.body));
        //print(response.body);
        if (response.statusCode == 200) {
          print(jsonDecode(response.body));
          return jsonDecode(response.body);
        }
        return null;
      } catch (e) {
        throw (e);
      }
    } else {
      return null;
    }
  }

  Future<bool> setUpBusiness({
    String token,
    String phoneNumber,
    String name,
    String address,
    String slogan,
    String logo,
    String signature,
    String currency,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = Uri.parse('$_urlEndpoint/business/info/create');
      var request = http.MultipartRequest('POST', uri);
      request.fields['name'] = name;
      request.fields['phone_number'] = phoneNumber;
      request.fields['address'] = address;

      if (slogan != null) {
        request.fields['slogan'] = slogan;
      }
      if (signature != null) {
        request.fields['signature'] = signature;
      }
      if (currency != null) {
        request.fields['currency'] = currency;
      }

      request.headers['token'] = token;
      if (logo != null) {
        request.files.add(
          await http.MultipartFile.fromPath("logo", logo),
        );
      }

      var response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        var businessId = jsonDecode(res)['id'];
        //set the token to null
        print('iddddd: $businessId');
        await _sharedPreferenceService.addStringToSF('Business_ID', businessId);
        await _sharedPreferenceService.addStringToSF('LOGO', logo);

        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  Future changeLogo(String logo) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = Uri.parse('$_urlEndpoint/business/info/update');
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

      var resp = await http
          .get('$_urlEndpoint/business/user/all', headers: {"token": token});
      var result;
      resp.statusCode == 200
          ? result = json.decode(resp.body)["data"] as List
          : print(resp.statusCode);
      print("this is the result");
      print(result);
      var businessID = result[0]["id"];
      await _sharedPreferenceService.addStringToSF('Business_ID', businessID);

      String bId =
          await _sharedPreferenceService.getStringValuesSF('Business_ID');

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
        await SharedPreferenceService().addStringToSF('LOGO', logo);
        return res;
      }
      return null;
    } else {
      return null;
    }
  }

  Future<String> changePassword(
      String currentPassword, String newPassword) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/user/change_password';
      var storedEmail =
          await _sharedPreferenceService.getStringValuesSF('EMAIL');
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
        print(response.statusCode);
        print('api post recieved!');
        if (response.statusCode == 200) {
          return "true";
        }
        return responseBody['message'] ?? responseBody['error'];
      } on SocketException {
        return "No network";
      }
    } else {
      return 'No network';
    }
  }

  businessExist() async {
    var url = "$_urlEndpoint/business/info/all";

    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

    String userID = await _sharedPreferenceService.getStringValuesSF('USER_ID');

    var email = await _sharedPreferenceService.getStringValuesSF('EMAIL');

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
      print(response.statusCode);
      res = res.firstWhere(
        (e) => e['user'] == userID,
        orElse: () {
          print('object');
        },
      );

      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else {
      return null;
    }
  }

  Future uploadSignature(String signature, String receiptId) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/receipt/upload/signature';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      String businessId =
          await _sharedPreferenceService.getStringValuesSF('Business_ID');
      print(businessId);

      print(
        """
     signature: $signature
      """,
      );

      try {
        var response = await http.put(
          uri,
          headers: <String, String>{
            "token": token,
          },
          body: {
            "signature": signature,
            "receiptId": receiptId,
          },
        );
        print(jsonDecode(response.body));

        if (response.statusCode == 200) {
          return jsonDecode(response.body);
        }
        return null;
      } catch (e) {
        throw (e);
      }
    } else {
      return null;
    }
  }

  //Fetch users from db;
  Future<AccountData> fetchAndSetUser() async {
    print('innn');
    var url = "$_urlEndpoint/business/user/all";

    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

    String userID = await _sharedPreferenceService.getStringValuesSF('USER_ID');

    print('userID: $userID');

    var email = await _sharedPreferenceService.getStringValuesSF('EMAIL');

    var connectivityResult = await Connected().checkInternet();

    print(connectivityResult);
    if (connectivityResult) {
      var response = await http.get(
        url,
        headers: <String, String>{
          'token': token,
        },
      );

      dynamic res;

      if (response != null &&
          response.statusCode == 200 &&
          jsonDecode(response.body)['data'].runtimeType != String) {
        dynamic res = jsonDecode(response.body);

        print('jhjhjre: ${jsonDecode(response.body)['data'].runtimeType}');
        res = res['data'] as List;

        res = res.firstWhere(
          (e) => e['user'].toString() == userID,
          orElse: () {
            print('object');
          },
        );
        if (res != null) {
          await _sharedPreferenceService.addStringToSF(
              'ISSUER_SIGNATURE', res['signature']);

          await _sharedPreferenceService.addStringToSF(
              'Currency', res['currency']);

          await _sharedPreferenceService.addStringToSF(
              'Business_ID', res['id']);
          return AccountData(
            id: res['id'],
            name: res['name'],
            phone: res['phone_number'],
            address: res['address'],
            slogan: res['slogan'],
            logo: kReleaseMode
                ? 'http://degeitreceipt.pythonanywhere.com${res['logo']}'
                : "http://degeittest.pythonanywhere.com${res['logo']}",
            email: email,
          );
        } else {
          print(jsonDecode(response.body));
          return null;
        }
      } else {
        return null;
      }
    } else {
      var result =
          await _sharedPreferenceService.getStringValuesSF('BUSINESS_INFO');
      var res = jsonDecode(result);
      return AccountData(
        id: res['id'] ?? '',
        name: res['name'] ?? '',
        phone: res['phone'] ?? '',
        address: res['address'] ?? '',
        slogan: res['slogan'] ?? '',
        logo: 'https://degeit-receipt.herokuapp.com${res['logo']}' ?? '',
        email: email,
      );
    }
  }

  Future getUserInfo() async {
    var url = "$_urlEndpoint/user/info";

    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

    var connectivityResult = await Connected().checkInternet();

    if (connectivityResult) {
      var response = await http.get(
        url,
        headers: <String, String>{
          'token': token,
        },
      );

      dynamic res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return res;
      } else {
        return null;
      }
    }
  }

  Future otpVerification(
    String email,
    password,
    name,
  ) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/user/otp_register';
      var response = await http.post(
        uri,
        body: {"email_address": "$email"},
      );

      return response;
    } else {
      return Future.value();
    }
  }

  Future<List<Receipt>> getIssuedReceipts() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = "$_urlEndpoint/business/receipt/issued";
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      List<Receipt> _issuedReceipts = [];

      var connectivityResult = await Connected().checkInternet();
      if (connectivityResult) {
        var response = await http.get(
          Uri.encodeFull(uri),
          headers: <String, String>{
            'token': token,
          },
        );
        log(response.body);
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print('data: $data');
          try {
            //log(response.body);
            data["data"].forEach((receipt) {
              _issuedReceipts.add(Receipt.fromJson(receipt));
              // Receipt.fromJson(receipt).toString();
            });
            // print(_issuedReceipts);
          } catch (e) {
            print(e);
          }
          return _issuedReceipts;
        } else {
          print("Issued Receipt status code ${json.decode(response.body)}");
          return [];
        }
      }
      return [];
    } else {
      return [];
    }
  }

  /// Returns a list of notifications
  /// if there are no notifications it returns an empty list
  Future getAllNotifications() async {
    var connectivityResult = await (Connected().checkInternet());
    if (connectivityResult) {
      var uri = "$_urlEndpoint/user/notification/all";
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      print(token);
      var connectivityResult = await (Connected().checkInternet());
      // List<NotificationModel> _allNotifications = [];
      if (connectivityResult) {
        var response = await http.get(
          Uri.encodeFull(uri),
          headers: <String, String>{
            'token': token,
          },
        );
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          var res = data["data"];
          if (res.length >= 100) {
            List temp = data["data"].getRange(0, 99).toList();
            await hiveDb.addNotification(temp);

            return res;
          } else if (data["data"].length < 100) {
            await hiveDb.addNotification(data["data"]);

            return hiveDb.getNotification();
          } else {
            return hiveDb.getNotification();
          }
        } else {
          print("All notifications status code ${response.statusCode}");
          return null;
        }
      }
    } else {
      return hiveDb.getNotification() ?? Future.error('No network Connection');
    }
  }

  Future getAllCustomers() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = "$_urlEndpoint/customer/all";
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

      List<Customer> _allCustomers = [];

      var connectivityResult = await Connected().checkInternet();
      if (connectivityResult) {
        var response = await http.get(
          Uri.encodeFull(uri),
          headers: <String, String>{
            'token': token,
          },
        );
        if (response.statusCode == 200) {
          // var res = response.data["data"] as List;
          var res = jsonDecode(response.body)['data'];
          print(res);
          // checks if the length of history is larger than 100 and checks for internet
          if (res.length >= 100) {
            List temp = res.getRange(0, 99).toList();
            await hiveDb.addCustomer(temp);

            // return hiveDb.getCustomer();
            return res;
          } else if (res.length < 100) {
            await hiveDb.addCustomer(res);

            return hiveDb.getCustomer();
            //return res;
          } else {
            print('res: 9');
            return hiveDb.getCustomer();
            //return res;
          }
        } else {
          var res = jsonDecode(response.body)['data'];
          return res;
        }
      }
    } else {
      return hiveDb.getCustomer() ?? Future.error('No network Connection');
    }
  }

  Future getAllInventories() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = "$_urlEndpoint/business/inventory/all";
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');

      var connectivityResult = await Connected().checkInternet();
      if (connectivityResult) {
        var response = await http.get(
          Uri.encodeFull(uri),
          headers: <String, String>{
            'token': token,
          },
        );
        if (response.statusCode == 200) {
          log(response.body);
          var data = jsonDecode(response.body)['data'];

          if (data.length >= 100) {
            List temp = data.getRange(0, 99).toList();
            await hiveDb.addInventory(temp);

            List res = data.map((e) {
              Inventory temp = Inventory.fromJson(e);
              return temp;
            }).toList();
            print('data: $res');
            return res;
          } else if (data.length < 100) {
            await hiveDb.addInventory(data);

            return hiveDb.getInventory();
          } else {
            print('res: 9');
            return hiveDb.getInventory();
          }
        } else {
          var res = jsonDecode(response.body)['data'];
          return null;
        }
      }
    } else {
      return hiveDb.getInventory() ?? Future.error('No network Connection');
    }
  }

  Future<Map<String, dynamic>> getIssuedReceipt2() async {
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    var connectivityResult = await Connected().checkInternet();
    String url = '$_urlEndpoint/business/receipt/issued';
    if (connectivityResult) {
      final http.Response res = await http.get(url, headers: <String, String>{
        "token": token,
      }).catchError((err) => print(err));
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        print(data);
        await hiveDb.addDashboardInfo(data);
        // var val = await hiveDb.getDashboardInfo();
        // return val;
        return data;
      } else {
        return null;
      }
    } else {
      var val = await hiveDb.getDashboardInfo();
      return val;
    }
  }

  Future forgotPasswordOtpVerification(String email) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/user/send_email';
      var response = await http.post(
        uri,
        body: {"email_address": email},
      );
      /* if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return response.body;
    } else {
     return response.body;
    } */
      return response;
    } else {
      return Future.value();
    }
  }

  Future<String> resetForgottenPassword(
    String email,
    String newPassword,
  ) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/user/forgot_password/';

      var response = await http.put(
        uri,
        body: {"email_address": "$email", "password": "$newPassword"},
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }

  Future googleSignup(String token, String email_address) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      String fcmToken = await _firebaseMessaging.getToken();
      String deviceType;
      //Check deviceType
      if (Device.get().isAndroid) {
        deviceType = 'andriod';
      } else if (Device.get().isIos) {
        deviceType = 'ios';
      }

      var uri = 'http://degeitreceipt.pythonanywhere.com/google';
      var response = await http.post(
        uri,
        body: {
          "deviceType": "$deviceType",
          "registration_id": "$fcmToken ",
          "token": "$token"
        },
      );
      print(response.body);
      print(response.statusCode);
      print(token);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String userId = data["data"]["_id"];
        // userID = userId;
        String auth_token = data["data"]["auth_token"];

        //Save details to Shared Preference
        _sharedPreferenceService.addStringToSF("USER_ID", userId);
        _sharedPreferenceService.addStringToSF("AUTH_TOKEN", auth_token);
        _sharedPreferenceService.addStringToSF("EMAIL", email_address);
        return 'true';
      }
      return 'false';
    } else {
      return Future.value();
    }
  }

  Future<String> addInventory(
    String category,
    String productName,
    double price,
    double quantity,
    String unit,
    double discount,
    double tax,
  ) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/inventory/add';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      var response = await http.post(
        uri,
        headers: {"token": token},
        body: {
          "category_name": "$category",
          "product_name": "$productName",
          "quantity": "$quantity",
          "price": "$price",
          "unit": "$unit",
          "discount": "$discount",
          "tax_amount": "$tax",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }

  Future<String> updateInventory({
    String id,
    String category,
    String productName,
    double price,
    double quantity,
    String unit,
    double tax,
    double discount,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/inventory/$id';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      print(token);
      var response = await http.put(
        uri,
        headers: {"token": token},
        body: {
          "inventory_id": "$id",
          "category_name": "$category",
          "product_name": "$productName",
          "quantity": "$quantity",
          "price": "$price",
          "unit": "$unit",
          "discount": "$discount",
          "tax_amount": "$tax",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }

  Future<String> deleteInventoryItem({
    String id,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/inventory/$id';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      print(token);
      var response = await http.delete(
        uri,
        headers: {"token": token},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }

  Future<String> deleteCustomer({
    String id,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/customer/$id';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      print(token);
      var response = await http.delete(
        uri,
        headers: {"token": token},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }

  Future<String> deleteDraft({
    String id,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/receipt/$id';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      print(token);
      var response = await http.delete(
        uri,
        headers: {"token": token},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }

  getPromotion() async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/promotions';
      var response = await http.get(
        uri,
      );
      String versionNumber =
          await _sharedPreferenceService.getStringValuesSF("VERSION");
      String isPromotion = "false";
      var res = json.decode(response.body);
      print("promotion response ");
      print(res['data']["id"]);
      if (response.statusCode == 200 &&
          res['data']['versionNumber'] != versionNumber &&
          isPromotion == 'false') {
        return res['data'];
      }
      return null;
    } else {
      return null;
    }
  }

  Future<List<Reminder>> getReminders() async {
    String token =
        await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
    print("token: $token");
    String url = '$_urlEndpoint/business/receipt/issued';

    final http.Response res = await http.get(url, headers: <String, String>{
      "token": token,
    }).catchError((err) => print(err));
    print(res.statusCode);
    if (res.statusCode == 200) {
      var responseData = json.decode(res.body);
      print("Reminder data");
      print(responseData['data']);
      return formatReminderResponse(responseData);
    } else {
      return null;
    }
  }

  updatePartPaymentReminder({
    String id,
    String date,
    String time,
  }) async {
    var connectivityResult = await Connected().checkInternet();
    if (connectivityResult) {
      var uri = '$_urlEndpoint/business/receipt/partpayment/$id';
      String token =
          await _sharedPreferenceService.getStringValuesSF('AUTH_TOKEN');
      print(token);
      var response = await http.put(
        uri,
        headers: {"token": token},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return 'true';
      }
      return 'false';
    } else {
      return 'false';
    }
  }
}
