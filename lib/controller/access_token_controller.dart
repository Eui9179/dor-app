import 'package:get/get.dart';

class AccessTokenController extends GetxController {
  String accessToken = '';

  void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
    update();
  }
  void clear(){
    accessToken = '';
    update();
  }
}
