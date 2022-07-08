import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/ui/dynamic_widget/input/outline_input.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import '../../../../utils/functions.dart';
import '../../../dynamic_widget/font/font.dart';

const List<String> gameList = [
  "leagueoflegends.jpg",
  "valorant.jpg",
  "battleground.jpg",
  "lostark.jpg",
  "tft.jpg",
  "minecraft.jpg",
  "fifa22.jpg",
  "overwatch.jpg",
  "starcraft.jpg",
  "starcraft2.jpg",
  "counterstrike.jpg",
  "apexlegends.jpg",
  "fortnite.jpg",
  "gta5.jpg",
  "dota2.jpg",
  "fallguys.jpg",
  "callofduty.jpg",
  "worldofwarcraft.jpg",
  "hearthstone.jpg",
  "maplestory.jpg",
  "suddenattack.jpg",
  "dungeonandfighter.jpg",
  "diablo2.jpg",
];

class Step3Game extends StatefulWidget {
  final Map profileData;

  const Step3Game({Key? key, required this.profileData}) : super(key: key);

  @override
  State<Step3Game> createState() => _Step3GameState();
}

class _Step3GameState extends State<Step3Game> {
  final List<Map> _gameList = List.generate(gameList.length,
      (index) => {'gameName': gameList[index], 'isSelected': false});

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
                onPressed: () {},
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
                    childAspectRatio: 2 / 1,
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
                                "assets/images/game/${_gameList[index]["gameName"]}",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 200,
                              ),
                            ),
                            Positioned(
                              bottom: 3,
                              left: 3,
                              child: Text(
                                changeKorGameName(
                                    _gameList[index]["gameName"].split(".")[0]),
                                // .jpg, .png 제외
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            _gameList[index]['isSelected']
                                ? const Positioned(
                                    top: 3,
                                    right: 3,
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
}

class FilteredImage extends StatelessWidget {
  const FilteredImage(
      {Key? key, required this.imageWidget, required this.isFiltered})
      : super(key: key);
  final Widget imageWidget;
  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    if (isFiltered) {
      return Stack(children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              Colors.blueAccent.withOpacity(0.4), BlendMode.srcOver),
          child: imageWidget,
        ),
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child:
                Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
          ),
        ),
      ]);
    } else {
      return imageWidget;
    }
  }
}
