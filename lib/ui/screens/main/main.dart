import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';
import 'main_bar.dart';
import 'my_friend_list.dart';
import 'my_game_list.dart';
import 'my_profile.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        appBar: const MainBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyProfile(),
              MyGameList(),
              MyFriendList(),
            ],
          ),
        ));
  }
}
