import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:flutter/material.dart';

const List<String> _userGameList = [
  "leagueoflegends.jpg",
  "valorant.jpg",
  "tft.jpg",
  "overwatch.jpg"
];

class MyGameList extends StatelessWidget {
  const MyGameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubjectTitle(title: "게임 목록"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 250.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return GameCard(gameName: _userGameList[index]);
            },
          ),
        ),
      ]
    );
  }
}
