import 'dart:convert';

import 'package:dor_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

Future<bool> dioApiUpdateMyGameList(
    String? accessToken, List<String> gameList) async {
  Dio dio = DioInstance().dio;
  dio.options.headers["content-Type"] = 'application/json';
  dio.options.headers["authorization"] = "Bearer $accessToken";

  try {
    await dio.post("game/me", data: jsonEncode(gameList));
    return true;
  } catch (e) {
    return false;
  } finally {
    dio.close();
  }
}
