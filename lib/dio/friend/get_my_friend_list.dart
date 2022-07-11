import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<dynamic> dioApiGetMyFriendList(String? accessToken) async {
  Dio dio = DioInstance().dio;
  dio.options.headers["content-Type"] = 'application/json';
  dio.options.headers["authorization"] = "Bearer $accessToken";
  try{
    Response response = await dio.get('/user/friend/me');
    print('get friend list ${response.data["my_friend_list"]}');
    return response.data["my_friend_list"];
  } catch (error){
    print(error);
  } finally {
    dio.close();
  }
}