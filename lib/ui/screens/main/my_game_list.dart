import 'package:dio/dio.dart';
import 'package:dor_app/dio/game/get_my_game_list.dart';
import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../utils/color_palette.dart';

// const List<String> _userGameList = [
//   "leagueoflegends.jpg",
//   "valorant.jpg",
//   "tft.jpg",
//   "overwatch.jpg"
// ];

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
      _getAccessTokenAndGameList();
    });
  }

  _getAccessTokenAndGameList() async {
    _accessToken = await storage.read(key: "accessToken");
    _getMyGameList();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SubjectTitle(title: "내 게임 목록"),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                  onPressed: () => {},
                  tooltip: "친구 동기화",
                  padding: EdgeInsets.zero,
                  // 패딩 삭제
                  constraints: const BoxConstraints(),
                  // 패딩 삭제
                  splashRadius: 15,
                  icon: const Icon(Icons.add,
                      color: ColorPalette.font, size: 22)),
            )
          ],
        ),

        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          height: 230.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _userGameList.length,
            itemBuilder: (BuildContext context, int index) {
              return GameCard(gameName: _userGameList[index]);
            },
          ),
        ),
      ]
    );
  }

  _getMyGameList(){
    Future<dynamic> response = dioApiGetMyGameList(_accessToken);
    response.then((gameList){
      setState(() {
        _userGameList = gameList;
      });
    }).catchError((error){
      print(error.toString());
      if(error is DioError){
        if (error.response != null){
          if(error.response!.statusCode == 401){
            notification(context, "다시 로그인 해주세요");
          }
        }
      }
    });

  }
}
