import 'package:contacts_service/contacts_service.dart';
import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/dio/friend/get_my_friends.dart';
import 'package:dor_app/dio/friend/sync_my_friends.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/friend_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/game_logo_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:dor_app/utils/sync_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MyFriendsInGroup extends StatefulWidget {
  const MyFriendsInGroup({Key? key}) : super(key: key);

  @override
  State<MyFriendsInGroup> createState() => _MyFriendsInGroupState();
}

class _MyFriendsInGroupState extends State<MyFriendsInGroup> {
  final List<dynamic> _myFriends = Get.arguments['friends'];
  final String groupName = Get.arguments['groupName'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorPalette.mainBackgroundColor,
        title: Text(
          groupName,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: ColorPalette.font),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13.0, left: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SubjectTitle(title: "내 게임 친구"),
                SubjectTitle(title: '${_myFriends.length.toString()} 명'),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemExtent: 75.0,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myFriends.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                    child: Row(
                      children: [
                        FriendAvatar(
                            image: _myFriends[index]["profile_image_name"]),
                        const SizedBox(
                          width: 13,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Font(text: _myFriends[index]["name"], size: 18),
                            _myFriends[index]['games'].length != 0
                                ? const SizedBox(
                                    height: 8,
                                  )
                                : const SizedBox(),
                            _myFriends[index]['games'].length != 0
                                ? Row(
                                    children: [
                                      if (_myFriends[index]['games'].length ==
                                          1) ...[
                                        GameLogoAvatar(
                                            gameName: _myFriends[index]['games']
                                                [0]),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const SubjectTitle(title: "함께 하는 게임 1개")
                                      ],
                                      if (_myFriends[index]['games'].length >
                                          1) ...[
                                        SizedBox(
                                          width: 52,
                                          child: Stack(children: [
                                            Positioned(
                                                left: 18,
                                                child: GameLogoAvatar(
                                                    gameName: _myFriends[index]
                                                        ['games'][1])),
                                            Positioned(
                                                child: GameLogoAvatar(
                                                    gameName: _myFriends[index]
                                                        ['games'][0])),
                                          ]),
                                        ),
                                        SubjectTitle(
                                            title:
                                                "함께 하는 게임 ${_myFriends[index]['games'].length}개")
                                      ]
                                    ],
                                  )
                                : const SizedBox()
                          ],
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
