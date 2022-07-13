
import 'package:dio/dio.dart';

String baseUri = "http://192.168.0.13:8000/api";

class DioInstance{
  final _dio = Dio();
  final String? _accessToken;

  DioInstance(this._accessToken) {
    _dio.options.baseUrl = baseUri;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 3000;
    if(_accessToken != null){
      _dio.options.headers["authorization"] = "Bearer $_accessToken";
      _dio.options.headers["content-Type"] = 'application/json';
    }
  }

  Dio get dio => _dio;
}