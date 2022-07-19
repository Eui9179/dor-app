import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/dio/friend/insert_friends.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/group_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/button/font_button.dart';
import 'package:dor_app/ui/static_widget/dividing_line.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
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
  String _accessToken = '';

  @override
  void initState() {
    super.initState();
    _initMyGroupDetail();
  }

  final String groupName = Get.parameters["name"]!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        followController();
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorPalette.headerBackgroundColor,
          title: const Text(
            "학교 게임 친구",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: ColorPalette.font),
          ),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: GroupAvatar(image: groupName)),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Font(
                          text: groupName,
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
              ),
              if (_friends.isNotEmpty) Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DividingLine(),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/acquaintance', arguments: {
                                'friends': _friends,
                                'kinds': groupName
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 4, bottom: 4),
                              child: Row(
                                children: [
                                  const Icon(Icons.people,
                                      color: Colors.white, size: 16),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Font(text: myFriendString, size: 16),
                                ],
                              ),
                            ),
                          ),
                          const DividingLine(),
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
                                            setState(() {
                                              _people[index]['isFollow'] = false;
                                            });
                                          },
                                          text: '취소',
                                          color: ColorPalette.font,
                                        )
                                      : FontButton(
                                          onPressed: () {
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
        dioApiGetPeopleByGroup(_accessToken, groupName);
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
          if (_friends.length == 1) {
            myFriendString = '${_friends[0]["name"]}님이 소속되어 있습니다.';
          } else if (_friends.length == 2) {
            myFriendString =
                '${_friends[0]["name"]}, ${_friends[1]["name"]}님이 소속되어 있습니다.';
          } else if (_friends.length > 2) {
            myFriendString =
                '${_friends[0]["name"]}, ${_friends[1]["name"]}님 외 ${_friends.length - 2}명이 소속되어 있습니다.';
          }
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      }
    });
  }

  void followController() {
    List<int> peopleToBeFriends = [];
    for (var person in _people) {
      if (person['isFollow']) {
        peopleToBeFriends.add(person['id']);
      }
    }
    if (peopleToBeFriends.isNotEmpty) {
      Future<Map<String, dynamic>> response =
          dioApiInsertFriends(_accessToken, peopleToBeFriends);
      response.then((res) {
        int statusCode = res['statusCode'];
        if (statusCode == 200) {
          List<dynamic> addedFriends = res['data'];
          print(addedFriends);
          List<dynamic> originalFriends =
              Get.find<MyFriendsController>().myFriends;
          Get.find<MyFriendsController>()
              .setMyFriends([...addedFriends, ...originalFriends]);
        } else {
          notification(context, "[$statusCode] 친구 등록할 때 문제가 발생했습니다. 다시 시도해주세요");
        }
      });
    }
  }
}
