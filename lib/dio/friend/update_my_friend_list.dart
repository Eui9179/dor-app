import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiUpdateMyFriendList(
    String? accessToken, List<String?> contacts) async {
  Dio dio = DioInstance(accessToken).dio;

  try {
    Response response = await dio.post('user/friend/sync', data: jsonEncode(contacts));
    return {"statusCode": response.statusCode};
  } on DioError catch (error) {
    print(error);
    return {"statusCode": error.response!.statusCode};
  }

  return {};
}
