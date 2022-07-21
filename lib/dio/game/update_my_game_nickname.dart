import 'package:dor_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> dioApiUpdateMyGamesNickname(
    String? accessToken, String game, String? nickname) async {
  Dio dio = DioInstance(accessToken).dio;

  try {
    Response response = await dio
        .post("/games/nickname", data: {'game': game, 'nickname': nickname});
    return {"statusCode": response.statusCode};
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
