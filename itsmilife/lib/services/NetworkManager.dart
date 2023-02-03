import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


  final storage = new FlutterSecureStorage();
  final Dio dio = Dio();
class NetworkManager {
  static const baseUrl = "http://51.145.251.116:80/";

  static init() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler){
        final token = storage.read(key: "token");

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options); //continue
      }
    ));
  }

  static Future<Response> get(String path) async {
    return dio.get(baseUrl + path);
  }

  static Future<Response> post(String path, dynamic data) async {
    return dio.post(baseUrl + path, data: data, options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  static Future<Response> put(String path, dynamic data) async {
    return dio.put(baseUrl + path, data: data, options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  static Future<Response> delete(String path, dynamic data) async {
    return dio.delete(baseUrl + path, data: data, options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  login(email, password) async {
    if (email.toString().isEmpty || password.toString().isEmpty) {
      return "Error: empty field";
    }
    try {
      return await dio.post('http://51.145.251.116:80/authenticate',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // Add other request types (put, delete, etc) as needed
} 

class AuthService {
  Dio dio = Dio();

  login(email, password) async {
    if (email.toString().isEmpty || password.toString().isEmpty) {
      return "Error: empty field";
    }
    try {
      return await dio.post('http://192.168.31.142:3000/authenticate',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
