import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiGetFriendsByGroupDetail1(String? accessToken, String name, String detail1) async {
  Dio dio = DioInstance(accessToken).dio;
  try {
    Response response = await dio.get('/user/groups/$name/$detail1');
    return {
      "statusCode": response.statusCode,
      "people": response.data["people"],
      "friends": response.data["friends"]
    };
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
