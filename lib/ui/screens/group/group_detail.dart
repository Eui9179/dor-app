import 'package:dor_app/ui/dynamic_widget/avatar/group_avatar.dart';
import 'package:dor_app/ui/static_widget/dividing_line.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/access_token_controller.dart';
import '../../../dio/group/get_people_by_group.dart';
import '../../../utils/color_palette.dart';
import '../../dynamic_widget/avatar/friend_avatar.dart';
import '../../dynamic_widget/avatar/game_logo_avatar.dart';
import '../../dynamic_widget/font/font.dart';
import '../../dynamic_widget/font/subject_title.dart';

class GroupDetail extends StatefulWidget {
  const GroupDetail({Key? key}) : super(key: key);

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  List<dynamic> _people = [];
  List<dynamic> _friends = [];
  String myFriendString = '';

  @override
  void initState() {
    super.initState();
    _initMyGroupDetail();
  }

  final String groupName = Get.parameters["name"]!;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorPalette.mainBackgroundColor,
    ));
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorPalette.mainBackgroundColor,
        title: const Text(
          "소속",
          style:  TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: ColorPalette.font),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 13.0, left: 13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    child: GroupAvatar(image: groupName)),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Font(
                      text: groupName,
                      size: 23,
                    ),
                    const SizedBox(height: 10,),
                    SubjectTitle(
                      title: '${_people.length+_friends.length}명이 소속되어 있습니다.',
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DividingLine(),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Row(
                      children: [
                        const Icon(Icons.people, color: Colors.white, size: 15),
                        const SizedBox(width: 8,),
                        Font(text: myFriendString, size: 15),
                      ],
                    ),
                  ),
                ),
                const DividingLine(),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('알 수도 있는 사람',
                    style: TextStyle(
                        color: Color.fromARGB(255, 172, 172, 172),
                        fontSize: 18)),
                Row(
                  children: [
                    SubjectTitle(title: '${_people.length.toString()} 명'),
                    const SizedBox(width: 10),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemExtent: 75.0,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _people.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FriendAvatar(
                                image: _people[index]["profile_image_name"]),
                            const SizedBox(
                              width: 13,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Font(text: _people[index]["name"], size: 18),
                                _people[index]['games'].length != 0
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : const SizedBox(),
                                _people[index]['games'].length != 0
                                    ? Row(
                                        children: [
                                          if (_people[index]['games'].length ==
                                              1) ...[
                                            GameLogoAvatar(
                                                gameName: _people[index]
                                                    ['games'][0]),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const SubjectTitle(
                                                title: "함께 하는 게임 1개")
                                          ],
                                          if (_people[index]['games'].length >
                                              1) ...[
                                            SizedBox(
                                              width: 52,
                                              child: Stack(children: [
                                                Positioned(
                                                    left: 18,
                                                    child: GameLogoAvatar(
                                                        gameName: _people[index]
                                                            ['games'][1])),
                                                Positioned(
                                                    child: GameLogoAvatar(
                                                        gameName: _people[index]
                                                            ['games'][0])),
                                              ]),
                                            ),
                                            SubjectTitle(
                                                title:
                                                    "함께 하는 게임 ${_people[index]['games'].length}개")
                                          ]
                                        ],
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ],
                        ),
                        Container(),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  void _initMyGroupDetail() {
    String accessToken = Get.find<AccessTokenController>().accessToken;

    Future<Map<String, dynamic>> response =
        dioApiGetPeopleByGroup(accessToken, groupName);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> resPeople = res['people'];
        List<dynamic> resFriends = res['friends'];
        setState(() {
          _people = resPeople;
          _friends = resFriends;
          if (_friends.length == 1){
            myFriendString = '${_friends[0]["name"]}님 이 소속되어 있습니다.';
          } else if(_friends.length == 2){
            myFriendString = '${_friends[0]["name"]}, ${_friends[1]["name"]}님 이 소속되어 있습니다.';
          } else if (_friends.length > 2){
            myFriendString = '${_friends[0]["name"]}, ${_friends[1]["name"]} 님 외 ${_friends.length - 2}명이 소속되어 있습니다.';
          }
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      }
    });
  }
}
