import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SubjectTitle(title: "게임 목록"),
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
