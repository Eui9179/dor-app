import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/dio/game/update_my_games.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../utils/dor_games.dart';

List<String> gameList = getDorGameList();

class GamesSetting extends StatefulWidget {
  const GamesSetting({Key? key}) : super(key: key);

  @override
  State<GamesSetting> createState() => _GamesSettingState();
}

class _GamesSettingState extends State<GamesSetting> {
  final List<Map> _gameList = List.generate(gameList.length,
      (index) => {'gameName': gameList[index], 'isSelected': false});
  late final String? _accessToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAccessToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorPalette.mainBackgroundColor,
          title: const Text(
            "게임선택",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: ColorPalette.font),
          ),
          actions: [
            IconButton(
                onPressed: _onPressed,
                icon: const Icon(
                  Icons.navigate_next_rounded,
                  size: 30,
                ))
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubjectTitle(title: "프로필에 보여질 게임을 선택해 주세요!"),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 1.1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(_gameList.length, (index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _gameList[index]['isSelected'] =
                                  !_gameList[index]['isSelected'];
                            });
                          },
                          child: Stack(children: [
                            ColorFiltered(
                              colorFilter: _gameList[index]['isSelected']
                                  ? ColorFilter.mode(
                                      const Color.fromARGB(255, 29, 60, 135)
                                          .withOpacity(0.7),
                                      BlendMode.srcOver)
                                  : ColorFilter.mode(
                                      Colors.black87.withOpacity(0.4),
                                      BlendMode.srcOver),
                              child: Image.asset(
                                "assets/images/game/${_gameList[index]["gameName"]}.jpg",
                                fit: BoxFit.cover,
                                height: 110,
                                width: 200,
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              left: 4,
                              child: Text(
                                changeKorGameName(_gameList[index]["gameName"]),
                                // .jpg, .png 제외
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            _gameList[index]['isSelected']
                                ? const Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  )
                                : const SizedBox(),
                          ]),
                        ),
                      );
                    })),
              ),
            ],
          ),
        ));
  }

  _onPressed() {
    Future<Map<String, dynamic>> response =
        dioApiUpdateMyGames(_accessToken, filterSelectedGameList());
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Get.offAllNamed('/');
      } else {
        print("step3Game _onPressed() error: $statusCode");
      }
    });
  }

  List<String> filterSelectedGameList() {
    List<String> selectedGameList = [];
    for (var element in _gameList) {
      if (element["isSelected"]) {
        selectedGameList.add(element["gameName"]);
      }
    }
    return selectedGameList;
  }

  _getAccessToken() {
    _accessToken = Get.find<AccessTokenController>().accessToken;
  }
}
