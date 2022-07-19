import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiGetUserProfile(
    String accessToken, int userId) async {
  Dio dio = DioInstance(accessToken).dio;
  try {
    Response response = await dio.post('user/profile/$userId');
    return {
      'statusCode': response.statusCode,
      'data': response.data['user_profile']
    };
  } on DioError catch (error) {
    return {'statusCode': error.response!.statusCode};
  } finally {
    dio.close();
  }
}
