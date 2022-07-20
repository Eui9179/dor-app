import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_groups_controller.dart';
import 'package:dor_app/controller/my_profile_controller.dart';
import 'package:dor_app/dio/group/get_my_groups.dart';
import 'package:dor_app/ui/static_widget/dividing_line.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dynamic_widget/button/group_text_button.dart';

class MyGroups extends StatefulWidget {
  const MyGroups({Key? key}) : super(key: key);

  @override
  State<MyGroups> createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  List<dynamic> _myGroups = [];

  @override
  void initState() {
    print('_initMyGroups');
    super.initState();
    _initMyGroups();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyGroupsController>(
      builder: (controller) {
        _myGroups = Get.find<MyGroupsController>().groups;
        return Container(
          padding: const EdgeInsets.only(left: 13, bottom: 15, right: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemExtent: 28.0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _myGroups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GroupTextButton(
                      text: _myGroups[index],
                      onTap: () {
                        Get.toNamed("/group/detail?name=${_myGroups[index]}");
                      },
                    );
                  }),
              const SizedBox(
                height: 5,
              ),
              const DividingLine()
            ],
          ),
        );
      },
    );
  }

  void _initMyGroups() {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response = dioApiGetMyGroups(accessToken);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        Get.find<MyGroupsController>().setMyGroups(res['data']);
      } else if (statusCode == 401) {
        notification(context, '다시 로그인 해주세요');
      }
    });
  }
}
