import 'package:dor_app/dio/game/get_my_game_list.dart';
import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/ui/screens/authentication/signup/step3_game.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../dynamic_widget/font/font.dart';

class MyGameList extends StatefulWidget {
  const MyGameList({Key? key}) : super(key: key);

  @override
  State<MyGameList> createState() => _MyGameListState();
}

class _MyGameListState extends State<MyGameList> {
  late final String? _accessToken;
  List<dynamic> _userGameList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initMyGameList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SubjectTitle(title: "내 게임 목록"),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              child: const SizedBox(
                height: 20,
                width: 30,
                child: Text(
                  "편집",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 172, 172, 172),
                      fontSize: 15,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          )
        ],
      ),
      _userGameList.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 230.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _userGameList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GameCard(gameName: _userGameList[index]);
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Step3Game(),
                            ));
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
  }

  _initMyGameList() async {
    _accessToken = await storage.read(key: "accessToken");
    _getMyGameList();
  }

  _getMyGameList() {
    Future<dynamic> response = dioApiGetMyGameList(_accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        setState(() {
          _userGameList = res["data"];
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      }
    });
  }
}
