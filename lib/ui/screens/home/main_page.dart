import 'package:flutter/material.dart';
import '../../../utils/color_palette.dart';
import 'main_page_bar.dart';
import 'my_friend_list.dart';
import 'my_game_list.dart';
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
              MyGameList(),
              MyFriendList(),
            ],
          ),
        ));
  }
}
