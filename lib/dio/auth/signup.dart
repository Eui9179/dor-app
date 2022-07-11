import 'package:dor_app/dio/dio_instance.dart';
import 'package:dio/dio.dart';

Future<String> dioApiSignup(Map profileData) async {
  FormData formData;
  Dio dio = DioInstance().dio;
  try {
    formData = FormData.fromMap({
      "file": profileData["file"] != null
          ? await MultipartFile.fromFile(profileData["file"].path)
          : null,
      "name": profileData["name"],
      "group": profileData["group"],
      "phone_number": profileData["phoneNumber"],
      "fcm_token": "12345r"
    });
    Response response = await dio.post('auth/signup', data: formData);
    return response.data["access_token"];

  } catch (e) {
    return "error";
  } finally {
    dio.close();
  }
  return "error";
}
