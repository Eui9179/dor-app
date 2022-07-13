import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiGetMyGameList(String? accessToken) async {
  Dio dio = DioInstance(accessToken).dio;
  try {
    Response response = await dio.get('game/me');
    print('get game list ${response.data["my_game_list"]}');

    return {"statusCode": 200, "data": response.data["my_game_list"]};
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  }
}
