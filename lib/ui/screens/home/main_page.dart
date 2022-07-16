import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/my_friends_controller.dart';
import '../../../utils/color_palette.dart';
import 'main_page_bar.dart';
import 'my_friends.dart';
import 'my_games.dart';
import 'my_groups.dart';
import 'my_profile.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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