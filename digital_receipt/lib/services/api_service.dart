import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'device_info_service.dart';

class ApiService {
  static DeviceInfoService deviceInfoService = DeviceInfoService();
  static String _urlEndpoint = "https://frozen-island-67494.herokuapp.com/v1";

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
    try {
      print(email_address);
      print(password);
      Response response = await _dio.post(
        "/user/login",
        data: {
          "password": '$password',
          "email_address": '$email_address',
          "deviceId": deviceId
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
        return "true";
      } else {
        print(response.data);
        return response.data["error"];
      }
    } on DioError catch (error) {
      print(error);
    }
  }
}
