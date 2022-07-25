import 'package:get/get.dart';

class MyProfileController extends GetxController {
  String name = '';
  String profileImage = 'default';
  String phoneNumber = '';

  void setMyProfile(String name, String profileImage, String phoneNumber) {
    this.name = name;
    this.profileImage = profileImage;
    this.phoneNumber = phoneNumber;
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
  void setMyPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    update();
  }
  void clear(){
    name = '';
    profileImage = 'default';
    phoneNumber = '';
    update();
  }
}
