import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<dynamic> dioApiGetMyGameList(String? accessToken) async {
  Dio dio = DioInstance().dio;
  dio.options.headers["content-Type"] = 'application/json';
  dio.options.headers["authorization"] = "Bearer $accessToken";

  try{
    Response response = await dio.get('/game/me');
    print('get game list ${response.data["my_game_list"]}');
    return response.data["my_game_list"];
  } catch (e){
    print(e.toString());
    return [];
  } finally {
    dio.close();
  }
} 