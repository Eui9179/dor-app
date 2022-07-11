import 'package:dor_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

Future<dynamic> dioApiLogin(String phoneNumber) async {
  Dio dio = DioInstance().dio;

  try {
    Response response = await dio.post('auth/login',
        data: {"phone_number": phoneNumber, "fcm_token": "12345r"});
    final jsonBody = response.data;
    return jsonBody["access_token"];
  } catch (error) {
    print("login error: $error.toString()");
    if (error is DioError){
      if(error.response != null ){
        if (error.response!.statusCode == 401){
          return 401;
        }
      }
    }
    return "500";

  } finally {
    dio.close();
  }
}
