import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/dio/friend/delete_friend.dart';
import 'package:dor_app/dio/friend/insert_friend.dart';
import 'package:dor_app/ui/dynamic_widget/button/font_button.dart';
import 'package:dor_app/ui/static_widget/dividing_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_palette.dart';
import '../../dynamic_widget/avatar/friend_avatar.dart';
import '../../dynamic_widget/avatar/game_logo_avatar.dart';
import '../../dynamic_widget/font/font.dart';
import '../../dynamic_widget/font/subject_title.dart';

class UserFriends extends StatefulWidget {
  const UserFriends(
      {Key? key,
      required this.alreadyFriends,
      required this.userFriends,
      required this.userName})
      : super(key: key);
  final List<dynamic> alreadyFriends;
  final List<dynamic> userFriends;
  final String userName;

  @override
  State<UserFriends> createState() => _UserFriendsState();
}

class _UserFriendsState extends State<UserFriends> {
  List<dynamic> userFriends = [];
  String myFriendString = '';

  @override
  void initState() {
    super.initState();
    setFriendString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: 13.0, left: 13.0, top: 15.0, bottom: 10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SubjectTitle(title: '${widget.userName}님의 게임 친구'),
            SubjectTitle(
                title:
                    '${userFriends.length + widget.alreadyFriends.length} 명'),
          ]),
        ),
        if (widget.alreadyFriends.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 13.0, left: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DividingLine(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/acquaintance', arguments: {
                      'friends': widget.alreadyFriends,
                      'kinds': '함께 아는 친구'
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.people, color: Colors.white, size: 16),
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
        if (userFriends.isNotEmpty) ...[
          ListView.builder(
              shrinkWrap: true,
              itemExtent: 75.0,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userFriends.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed('/users/${userFriends[index]['id']}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                    child: Row(
                      children: [
                        FriendAvatar(
                            image: userFriends[index]["profile_image_name"]),
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
                                      text: userFriends[index]["name"],
                                      size: 18),
                                  userFriends[index]['games'].length != 0
                                      ? const SizedBox(
                                          height: 8,
                                        )
                                      : const SizedBox(),
                                  userFriends[index]['games'].length != 0
                                      ? Row(
                                          children: [
                                            if (userFriends[index]['games']
                                                    .length ==
                                                1) ...[
                                              GameLogoAvatar(
                                                  gameName: userFriends[index]
                                                      ['games'][0]),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const SubjectTitle(
                                                  title: "함께 하는 게임 1개")
                                            ],
                                            if (userFriends[index]['games']
                                                    .length >
                                                1) ...[
                                              SizedBox(
                                                width: 52,
                                                child: Stack(children: [
                                                  Positioned(
                                                      left: 18,
                                                      child: GameLogoAvatar(
                                                          gameName:
                                                              userFriends[index]
                                                                      ['games']
                                                                  [1])),
                                                  Positioned(
                                                      child: GameLogoAvatar(
                                                          gameName:
                                                              userFriends[index]
                                                                      ['games']
                                                                  [0])),
                                                ]),
                                              ),
                                              SubjectTitle(
                                                  title:
                                                      "함께 하는 게임 ${userFriends[index]['games'].length}개")
                                            ]
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              ),
                              userFriends[index]['isFollow']
                                  ? FontButton(
                                      onPressed: () {
                                        deleteFriendFromMyFriends(
                                            userFriends[index]['id'], index);
                                      },
                                      text: '취소',
                                      color: ColorPalette.font,
                                    )
                                  : FontButton(
                                      onPressed: () {
                                        insertFriendsIntoMyFriends(
                                            userFriends[index]['id'], index);
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
        ]
      ],
    );
  }

  setFriendString() {
    setState(() {
      userFriends = List.generate(widget.userFriends.length,
          (index) => {...widget.userFriends[index], 'isFollow': false});
    });
    if (widget.alreadyFriends.length == 1) {
      myFriendString = '${widget.alreadyFriends[0]["name"]}님과 함께 알고 있습니다.';
    } else if (widget.alreadyFriends.length == 2) {
      myFriendString =
          '${widget.alreadyFriends[0]["name"]}, ${widget.alreadyFriends[1]["name"]}님과 함께 알고 있습니다.';
    } else if (widget.alreadyFriends.length > 2) {
      myFriendString =
          '${widget.alreadyFriends[0]["name"]}, ${widget.alreadyFriends[1]["name"]}님 외 ${widget.alreadyFriends.length - 2}명과 함께 알고 있습니다.';
    }
  }

  insertFriendsIntoMyFriends(int friendId, int index) {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response =
        dioApiInsertFriendOne(accessToken, friendId);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> originalFriends =
            Get.find<MyFriendsController>().myFriends;
        Get.find<MyFriendsController>()
            .setMyFriends([res['data'], ...originalFriends]);
        setState(() {
          userFriends[index]['isFollow'] = true;
        });
      } else {
        print('insertFriendsIntoFriends(): $statusCode');
      }
    });
  }

  deleteFriendFromMyFriends(int friendId, int index) {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response =
        dioApiDeleteFriendOne(accessToken, friendId);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> originalFriends =
            Get.find<MyFriendsController>().myFriends;
        originalFriends.removeAt(index);
        Get.find<MyFriendsController>().setMyFriends([...originalFriends]);
        setState(() {
          userFriends[index]['isFollow'] = false;
        });
      } else {
        print('insertFriendsIntoFriends(): $statusCode');
      }
    });
  }
}
