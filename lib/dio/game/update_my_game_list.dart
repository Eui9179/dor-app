import 'dart:convert';
import 'package:dor_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> dioApiUpdateMyGameList(
    String? accessToken, List<String> gameList) async {
  Dio dio = DioInstance(accessToken).dio;

  try {
    Response response = await dio.post("/game/me", data: jsonEncode(gameList));
    return {"statusCode": response.statusCode};
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
