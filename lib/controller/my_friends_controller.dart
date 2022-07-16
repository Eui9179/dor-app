import 'package:get/get.dart';

import '../dio/friend/get_my_friends.dart';

class MyFriendsController extends GetxController {
  List<dynamic> myFriends = [];

  void setMyFriends(List<dynamic> newMyFriends) {
    myFriends = newMyFriends;
    update();
  }
}
