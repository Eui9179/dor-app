import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, String>> getMyProfile(accessToken) async {
  Dio dio = DioInstance().dio;
  dio.options.headers["content-Type"] = 'application/json';
  dio.options.headers["authorization"] = "Bearer $accessToken";

  try{
    Response response = await dio.get('user/profile/me');
    final jsonData = response.data["me"];

    Map<String, String> myProfileData = {
      "name": jsonData["name"],
      "phoneNumber": jsonData["phone_number"],
      "group": jsonData["group"],
      "profileImageName": jsonData["profile_image_name"],
    };
    return myProfileData;
  } catch (e) {
    print(e.toString());
    Map<String, String> error = {
      "error":"error"
    };
    return error;
  } finally{
    dio.close();
  }

}