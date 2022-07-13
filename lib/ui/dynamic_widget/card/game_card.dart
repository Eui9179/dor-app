import 'package:dor_app/utils/dor_games.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  const GameCard({Key? key, required this.gameName}) : super(key: key);

  final String gameName;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10.0, bottom: 8.0, top: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black87.withOpacity(0.4), BlendMode.srcOver),
              child: Image.asset(
                "assets/images/game/$gameName.jpg",
                width: 150,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                changeKorGameName(gameName), // .jpg, .png 제외
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Positioned(
              top: 7,
              right: 5,
              child: Material(
                color: Color.fromARGB(0, 255, 255, 255),
                child: IconButton(
                    onPressed: () {
                      print("pressed");
                    },
                    tooltip: "더보기",
                    splashRadius: 12,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    splashColor: Color.fromARGB(169, 255, 255, 255),
                    icon: const Icon(Icons.more_vert,
                        color: Colors.white, size: 20)),
              ),
            ),
          ]),
        ),
      );
  }
}
