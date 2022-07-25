import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_games_controller.dart';
import 'package:dor_app/dio/game/get_my_games.dart';
import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dynamic_widget/font/font.dart';

class MyGames extends StatefulWidget {
  const MyGames({Key? key}) : super(key: key);

  @override
  State<MyGames> createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  late final String? _accessToken;
  List<dynamic> _userGameList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _initMyGameList();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyGamesController>(
      builder: (controller) {
        _userGameList = controller.games;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 13.0, right: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SubjectTitle(title: "내 게임 목록"),
                InkWell(
                  onTap: () {
                    Get.toNamed('/setting/games?type=setting');
                  },
                  child: const SizedBox(
                    height: 20,
                    width: 40,
                    child: Text(
                      "편집",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 172, 172, 172),
                          fontSize: 17,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _userGameList.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 5.0, left: 13),
                  height: 230.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _userGameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GameCard(
                        gameName: _userGameList[index]['game'],
                        isMe: true,
                        nickname: _userGameList[index]['nickname'],
                      );
                    },
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  height: 120.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.toNamed('/setting/games?type=setting');
                          },
                          child: const Text("게임등록",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                              ))),
                      const Font(text: "을 해보세요!", size: 18),
                    ],
                  ),
                ),
        ]);
      },
    );
  }

  _initMyGameList() {
    print('_initMyGameList');
    _accessToken = Get.find<AccessTokenController>().accessToken;
    _getMyGameList();
  }

  _getMyGameList() {
    Future<dynamic> response = dioApiGetMyGames(_accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        print(res['data']);
        Get.find<MyGamesController>().setMyGames(res['data']);
        setState(() {
          _userGameList = Get.find<MyGamesController>().games;
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      }
    });
  }
}
