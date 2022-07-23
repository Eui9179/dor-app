import 'package:dor_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> dioApiSignup(Map profileData) async {
  FormData formData;
  Dio dio = DioInstance(null).dio;
  try {
    formData = FormData.fromMap({
      "file": profileData["file"] != null
          ? await MultipartFile.fromFile(profileData["file"].path)
          : null,
      "name": profileData["name"],
      "groups": profileData["groups"],
      "detail1": profileData["detail1"],
      "phone_number": profileData["phoneNumber"],
      "fcm_token": profileData["fcmToken"]
    });
    Response response = await dio.post('/auth/signup', data: formData);
    return {
      "statusCode": response.statusCode,
      "data": response.data["access_token"]
    };
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
