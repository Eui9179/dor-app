import 'package:flutter/material.dart';

import 'my_friend_list.dart';
import 'my_game_list.dart';
import 'my_profile.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      MyProfile(),
      MyGameList(),
      MyFriendList(),
    ]);
  }
}
