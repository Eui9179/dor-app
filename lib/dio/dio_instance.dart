
import 'package:dio/dio.dart';

String baseUri = "http://172.30.1.4:8000/api/";

class DioInstance{
  final _dio = Dio();
  final String? accessToken;

  DioInstance(this.accessToken) {
    _dio.options.baseUrl = baseUri;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 3000;
    if(accessToken != null){
      _dio.options.headers["authorization"] = "Bearer $accessToken";
      _dio.options.headers["content-Type"] = 'application/json';
    }
  }

  Dio get dio => _dio;
}