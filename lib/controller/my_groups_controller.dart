import 'package:get/get.dart';

class MyGroupsController extends GetxController {
  List<dynamic> groups = [];

  void setMyGroups(List<dynamic> groups) {
    this.groups = groups;
    update();
  }

  void clear(){
    groups = [];
    update();
  }
}
