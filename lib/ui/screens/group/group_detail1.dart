import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/dio/friend/insert_friends.dart';
import 'package:dor_app/dio/group/get_friends_by_group_detail1.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/group_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/button/font_button.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/access_token_controller.dart';
import '../../../dio/friend/delete_friend.dart';
import '../../../dio/friend/insert_friend.dart';
import '../../../utils/color_palette.dart';
import '../../dynamic_widget/avatar/friend_avatar.dart';
import '../../dynamic_widget/avatar/game_logo_avatar.dart';
import '../../dynamic_widget/font/font.dart';
import '../../dynamic_widget/font/subject_title.dart';

class GroupDetail1 extends StatefulWidget {
  const GroupDetail1({Key? key}) : super(key: key);

  @override
  State<GroupDetail1> createState() => _GroupDetail1State();
}

class _GroupDetail1State extends State<GroupDetail1> {
  List<dynamic> _people = [];
  List<dynamic> _friends = [];
  String _accessToken = '';

  @override
  void initState() {
    super.initState();
    _initMyGroupDetail();
  }

  final String groupName = Get.parameters["name"]!;
  final String detail1 = Get.parameters["detail1"]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0.0,
          backgroundColor: ColorPalette.headerBackgroundColor,
          title: const Text(
            "학교 게임 친구",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: ColorPalette.font),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            child: GroupAvatar(image: groupName)),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Font(
                                  text: '$groupName $detail1학년',
                                  size: 23,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SubjectTitle(
                                  title:
                                      '${_people.length + _friends.length}명이 소속되어 있습니다.',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    FontButton(
                      onPressed: () {
                        Get.toNamed("/group/detail?name=$groupName");
                      },
                      text: '전체 보기',
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$groupName 친구들',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 172, 172, 172),
                            fontSize: 18)),
                    Row(
                      children: [
                        SubjectTitle(title: '${_friends.length.toString()} 명'),
                        const SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemExtent: 75.0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _friends.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed('/users/${_friends[index]['id']}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                        child: Row(
                          children: [
                            FriendAvatar(
                                image: _friends[index]["profile_image_name"]),
                            const SizedBox(
                              width: 13,
                            ),
                            Expanded(
                              flex: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Font(
                                          text: _friends[index]["name"],
                                          size: 18),
                                      _friends[index]['games'].length != 0
                                          ? const SizedBox(
                                              height: 8,
                                            )
                                          : const SizedBox(),
                                      _friends[index]['games'].length != 0
                                          ? Row(
                                              children: [
                                                if (_friends[index]['games']
                                                        .length ==
                                                    1) ...[
                                                  GameLogoAvatar(
                                                      gameName: _friends[index]
                                                          ['games'][0]),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const SubjectTitle(
                                                      title: "함께 하는 게임 1개")
                                                ],
                                                if (_friends[index]['games']
                                                        .length >
                                                    1) ...[
                                                  SizedBox(
                                                    width: 52,
                                                    child: Stack(children: [
                                                      Positioned(
                                                          left: 18,
                                                          child: GameLogoAvatar(
                                                              gameName: _friends[
                                                                      index]
                                                                  ['games'][1])),
                                                      Positioned(
                                                          child: GameLogoAvatar(
                                                              gameName: _friends[
                                                                      index]
                                                                  ['games'][0])),
                                                    ]),
                                                  ),
                                                  SubjectTitle(
                                                      title:
                                                          "함께 하는 게임 ${_friends[index]['games'].length}개")
                                                ]
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 13.0, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('알 수도 있는 친구들',
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
                      onTap: () {
                        Get.toNamed('/users/${_people[index]['id']}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                        child: Row(
                          children: [
                            FriendAvatar(
                                image: _people[index]["profile_image_name"]),
                            const SizedBox(
                              width: 13,
                            ),
                            Expanded(
                              flex: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Font(
                                          text: _people[index]["name"], size: 18),
                                      _people[index]['games'].length != 0
                                          ? const SizedBox(
                                              height: 8,
                                            )
                                          : const SizedBox(),
                                      _people[index]['games'].length != 0
                                          ? Row(
                                              children: [
                                                if (_people[index]['games']
                                                        .length ==
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
                                                if (_people[index]['games']
                                                        .length >
                                                    1) ...[
                                                  SizedBox(
                                                    width: 52,
                                                    child: Stack(children: [
                                                      Positioned(
                                                          left: 18,
                                                          child: GameLogoAvatar(
                                                              gameName: _people[
                                                                      index]
                                                                  ['games'][1])),
                                                      Positioned(
                                                          child: GameLogoAvatar(
                                                              gameName: _people[
                                                                      index]
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
                                  _people[index]['isFollow']
                                      ? FontButton(
                                          onPressed: () {
                                            deleteFriendFromMyFriends(_people[index]['id']);
                                            setState(() {
                                              _people[index]['isFollow'] = false;
                                            });
                                          },
                                          text: '취소',
                                          color: ColorPalette.subFont,
                                        )
                                      : FontButton(
                                          onPressed: () {
                                            insertFriendsIntoMyFriends(_people[index]['id']);
                                            setState(() {
                                              _people[index]['isFollow'] = true;
                                            });
                                          },
                                          text: '친구 추가',
                                          color: Colors.blueAccent,
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      );
  }

  void _initMyGroupDetail() {
    _accessToken = Get.find<AccessTokenController>().accessToken;

    Future<Map<String, dynamic>> response =
        dioApiGetFriendsByGroupDetail1(_accessToken, groupName, detail1);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> resPeople = res['people'];
        final List<Map> newResPeople = List.generate(resPeople.length,
            (index) => {...resPeople[index], 'isFollow': false});
        List<dynamic> resFriends = res['friends'];
        setState(() {
          _people = newResPeople;
          _friends = resFriends;
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      }
    });
  }
  insertFriendsIntoMyFriends(int userId) {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response =
    dioApiInsertFriendOne(accessToken, userId);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> originalFriends =
            Get.find<MyFriendsController>().myFriends;
        Get.find<MyFriendsController>()
            .setMyFriends([res['data'], ...originalFriends]);
      } else {
        print('insertFriendsIntoFriends(): $statusCode');
      }
    });
  }

  deleteFriendFromMyFriends(int userId) {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response =
    dioApiDeleteFriendOne(accessToken, userId);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> originalFriends =
            Get.find<MyFriendsController>().myFriends;
        for(int i=0; i<originalFriends.length; i++){
          if(originalFriends[i]['id'] == userId){
            originalFriends.removeAt(i);
            break;
          }
        }
        Get.find<MyFriendsController>().setMyFriends([...originalFriends]);
      } else {
        print('insertFriendsIntoFriends(): $statusCode');
      }
    });
  }
}
