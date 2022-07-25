import 'package:get/get.dart';

class MyFriendsController extends GetxController {
  List<dynamic> myFriends = [];

  void setMyFriends(List<dynamic> newMyFriends) {
    myFriends = newMyFriends;
    update();
  }
  void clear(){
    myFriends = [];
    update();
  }
}
