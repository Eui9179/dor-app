import 'dart:async';

import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/controller/my_games_controller.dart';
import 'package:dor_app/controller/my_groups_controller.dart';
import 'package:dor_app/controller/my_profile_controller.dart';
import 'package:dor_app/dio/friend/get_my_friends.dart';
import 'package:dor_app/dio/game/get_my_games.dart';
import 'package:dor_app/dio/profile/get_my_profile.dart';
import 'package:dor_app/ui/screens/main_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dio/group/get_my_groups.dart';
import '../../../utils/color_palette.dart';
import 'main_page_bar.dart';
import 'my_friends.dart';
import 'my_games.dart';
import 'my_groups.dart';
import 'my_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _initUserData().then((val) {
      Timer(const Duration(milliseconds: 1500), () {
        setState((){
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MainLoadingScreen();
    } else {
      return Scaffold(
          backgroundColor: ColorPalette.mainBackgroundColor,
          appBar: const MainPageBar(),
          body: SingleChildScrollView(
            child: Column(
              children: const [
                MyProfile(),
                MyGroups(),
                MyGames(),
                MyFriends(),
              ],
            ),
          ));
    }
  }

  Future<bool> _initUserData() async {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    _initMyProfile(accessToken);
    _initMyGroups(accessToken);
    _initMyGameList(accessToken);
    _initMyFriendList(accessToken);

    return true;
  }

  _initMyProfile(String accessToken) {
    Future<Map<String, dynamic>> response = dioApiGetMyProfile(accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Map<String, dynamic> profileData = res["data"];
        Get.find<MyProfileController>().setMyProfile(profileData["name"],
            profileData["profile_image_name"], profileData["phone_number"]);
      } else if (statusCode == 401) {
      } else {
        print("_getMyProfile() error: $statusCode");
      }
    });
  }

  void _initMyGroups(String accessToken) {
    Future<Map<String, dynamic>> response = dioApiGetMyGroups(accessToken);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        Get.find<MyGroupsController>().setMyGroups(res['data']);
      } else if (statusCode == 401) {}
    });
  }

  void _initMyGameList(String accessToken) {
    Future<dynamic> response = dioApiGetMyGames(accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Get.find<MyGamesController>().setMyGames(res['data']);
      } else if (statusCode == 401) {}
    });
  }

  void _initMyFriendList(String accessToken) {
    Future<dynamic> response = dioApiGetMyFriends(accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Get.find<MyFriendsController>().setMyFriends(res['data']);
      } else if (statusCode == 401) {
      } else {
        print('_getMyFriendList() error: $statusCode');
      }
    });
  }
}
