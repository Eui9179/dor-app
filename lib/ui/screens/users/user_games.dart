import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:flutter/material.dart';

class UserGames extends StatelessWidget {
  const UserGames({Key? key, required this.userGames, required this.userName})
      : super(key: key);
  final List<dynamic> userGames;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubjectTitle(title: "$userName 님의 게임 목록"),
          ],
        ),
      ),
      userGames.isNotEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 5.0, left: 13),
              height: 230.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userGames.length,
                itemBuilder: (BuildContext context, int index) {
                  return GameCard(gameName: userGames[index]['game'], isMe: false, nickname: userGames[index]['nickname'],);
                },
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 70.0,
              child: const Center(
                    child: Text("등록된 게임이 없습니다",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blueAccent,
                        )),
                  ),

            ),
    ]);
  }
}
