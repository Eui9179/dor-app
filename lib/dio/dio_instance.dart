
import 'package:dio/dio.dart';

class DioInstance{
  final _dio = Dio();
  DioInstance(){
    _dio.options.baseUrl = 'http://192.168.0.13:8000/api/';
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 3000;
  }
  setAuthorization(String accessToken){
    _dio.options.headers["content-Type"] = 'application/json';
    _dio.options.headers["authorization"] = "Bearer $accessToken";
  }
  Dio get dio => _dio;
}