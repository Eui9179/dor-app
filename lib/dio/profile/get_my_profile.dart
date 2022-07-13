import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiGetMyProfile(accessToken) async {
  Dio dio = DioInstance(accessToken).dio;
  Response response = await dio.get('user/profile/me');
  try {
    return {"statusCode": 200, "data": response.data["my_profile"]};
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  }
}
