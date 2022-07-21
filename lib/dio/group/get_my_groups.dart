import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiGetMyGroups(String? accessToken) async {
  Dio dio = DioInstance(accessToken).dio;
  try {
    Response response = await dio.get('/user/groups/me');
    return {
      "statusCode": response.statusCode,
      "data": response.data["my_groups"]
    };
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
