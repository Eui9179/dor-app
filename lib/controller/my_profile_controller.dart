import 'package:get/get.dart';

class MyProfileController extends GetxController {
  String name = '';
  String profileImage = 'default';

  void setMyProfile(String name, String profileImage) {
    this.name = name;
    this.profileImage = profileImage;
    update();
  }
  void setMyName(String name) {
    this.name = name;
    update();
  }
  void setMyProfileImage(String profileImage) {
    this.profileImage = profileImage;
    update();
  }
}
