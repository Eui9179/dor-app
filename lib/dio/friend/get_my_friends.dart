import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiGetMyFriends(String? accessToken) async {
  Dio dio = DioInstance(accessToken).dio;
  try {
    Response response = await dio.get('/user/friends/me');
    return {
      "statusCode": response.statusCode,
      "data": response.data["my_friends"]
    };
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
