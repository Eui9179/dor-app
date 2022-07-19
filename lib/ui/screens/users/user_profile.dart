import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/profile_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/button/font_button.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dio/friend/delete_friend.dart';
import '../../../dio/friend/insert_friend.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.userProfile, required this.isFriend}) : super(key: key);
  final Map<String, dynamic> userProfile;
  final bool isFriend;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isFriend = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFriend = widget.isFriend;
    });
  }
  @override
  Widget build(BuildContext context) {
    String userProfileImageName = widget.userProfile['profile_image_name']!;
    String name = widget.userProfile['name']!;

    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.only(top: 15, bottom: 20, right: 13, left: 13),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorPalette.headerBackgroundColor,
                ColorPalette.mainBackgroundColor
              ],
              stops: [
                0.4,
                0.4
              ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ProfileAvatar(
          image: userProfileImageName,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.font)),
            isFriend? FontButton(
              onPressed: () {
                deleteFriendFromMyFriends();
              },
              text: '친구 삭제',
              color: ColorPalette.subFont,
            )
                : FontButton(
              onPressed: () {
                insertFriendsIntoMyFriends();
              },
              text: '친구 추가',
              color: Colors.blueAccent,
            )
          ],
        ),
      ]),
    );
  }
  insertFriendsIntoMyFriends() {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response =
      dioApiInsertFriendOne(accessToken, widget.userProfile['user_id']);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> originalFriends =
            Get.find<MyFriendsController>().myFriends;
        Get.find<MyFriendsController>()
            .setMyFriends([res['data'], ...originalFriends]);
        setState(() {
          isFriend = !isFriend;
        });
      } else {
        print('insertFriendsIntoFriends(): $statusCode');
      }
    });
  }

  deleteFriendFromMyFriends() {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response =
    dioApiDeleteFriendOne(accessToken, widget.userProfile['user_id']);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        List<dynamic> originalFriends =
            Get.find<MyFriendsController>().myFriends;
        for(int i=0; i<originalFriends.length; i++){
          if(originalFriends[i]['id'] == widget.userProfile['user_id']){
            originalFriends.removeAt(i);
            break;
          }
        }
        Get.find<MyFriendsController>().setMyFriends([...originalFriends]);
        setState(() {
          isFriend = !isFriend;
        });
      } else {
        print('insertFriendsIntoFriends(): $statusCode');
      }
    });
  }
}