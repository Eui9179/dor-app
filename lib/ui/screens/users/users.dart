import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/dio/profile/get_user.dart';
import 'package:dor_app/ui/screens/home/profile_loading_screen.dart';
import 'package:dor_app/ui/screens/users/user_friends.dart';
import 'package:dor_app/ui/screens/users/user_games.dart';
import 'package:dor_app/ui/screens/users/user_groups.dart';
import 'package:dor_app/ui/screens/users/user_profile.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final int userId = int.parse(Get.parameters['userId']!);
  Map<String, dynamic> _userProfile = {};
  List<dynamic> _userGroups = [];
  List<dynamic> _userGames = [];
  List<dynamic> _alreadyFriends = [];
  List<dynamic> _userFriends = [];
  bool _isFriend = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ProfileLoadingScreen()
        : Scaffold(
            backgroundColor: ColorPalette.mainBackgroundColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: ColorPalette.headerBackgroundColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  UserProfile(userProfile: _userProfile, isFriend: _isFriend),
                  UserGroups(
                    userGroups: _userGroups,
                  ),
                  UserGames(
                      userGames: _userGames, userName: _userProfile['name']),
                  UserFriends(
                      alreadyFriends: _alreadyFriends,
                      userFriends: _userFriends,
                      userName: _userProfile['name'])
                ],
              ),
            ));
  }

  _initUser() {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response = dioApiUser(accessToken, userId);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        print(res['data']);
        _userProfile = res['data']['userProfile'];
        _isFriend = res['data']['isFriend'];
        _userGroups = res['data']['userGroups'];
        _userGames = res['data']['userGames'];
        _alreadyFriends = res['data']['alreadyFriends'];
        _userFriends = res['data']['userFriends'];

        setState(() {
          isLoading = false;
        });
      } else {
        print('users initUser: $statusCode');
      }
    });
  }
}
