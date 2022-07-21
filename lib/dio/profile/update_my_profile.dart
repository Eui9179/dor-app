import 'package:dio/dio.dart';
import 'package:dor_app/dio/dio_instance.dart';

Future<Map<String, dynamic>> dioApiUpdateMyProfile(Map profileData, String accessToken) async {
  FormData formData;
  Dio dio = DioInstance(accessToken).dio;
  try {
    formData = FormData.fromMap({
      "is_file": profileData['isFile'],
      "file": profileData["file"] != null
          ? await MultipartFile.fromFile(profileData["file"].path)
          : null,
      "name": profileData["name"],
      "groups": profileData["groups"],
    });
    Response response = await dio.post('/user/setting', data: formData);
    return {
      "statusCode": response.statusCode,
      'data': response.data['res_image_name'],
    };
  } on DioError catch (error) {
    return {"statusCode": error.response!.statusCode};
  } finally {
    dio.close();
  }
}
