import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/utils/dor_games.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/color_palette.dart';
import '../../dynamic_widget/avatar/friend_avatar.dart';
import '../../dynamic_widget/font/font.dart';
import '../../dynamic_widget/font/subject_title.dart';

class FriendsInGame extends StatefulWidget {
  const FriendsInGame({Key? key}) : super(key: key);

  @override
  State<FriendsInGame> createState() => _FriendsInGameState();
}

class _FriendsInGameState extends State<FriendsInGame> {
  final List<dynamic> _friends = [];
  final String gameName = Get.parameters["gameName"]!;

  @override
  void initState() {
    super.initState();
    List<dynamic> friends = Get.find<MyFriendsController>().myFriends;
    for (var friend in friends) {
      if (friend['games'].contains(gameName)) {
        _friends.add(friend);
      }
    }
    print(_friends);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0.0,
          titleSpacing: 0,
          backgroundColor: ColorPalette.headerBackgroundColor,
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image(
                    image: AssetImage(
                        'assets/images/game/logo/${gameName}_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                changeKorGameName(gameName),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          // flexibleSpace: Image(
          //   image: AssetImage('assets/images/game/logo/${gameName}_logo.png'),
          //   fit: BoxFit.cover,
          // )
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SubjectTitle(title: '내 게임 친구'),
                SubjectTitle(title: '${_friends.length.toString()} 명'),
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
                                  Font(text: _friends[index]["name"], size: 18),
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
                                              const SubjectTitle(
                                                  title: "함께 하는 게임 1개")
                                            ],
                                            if (_friends[index]['games']
                                                    .length >
                                                1) ...[
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
        ],
      ),
    );
  }
}
