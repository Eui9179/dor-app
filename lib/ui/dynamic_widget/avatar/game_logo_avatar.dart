import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/dor_games.dart';
import 'package:flutter/material.dart';

class GameLogoAvatar extends StatelessWidget {
  const GameLogoAvatar({Key? key, required this.gameName, required this.matrix}) : super(key: key);
  final double matrix;
  final String gameName;

  @override
  Widget build(BuildContext context) {
    return  Container(
      transform: Matrix4.translationValues(matrix, 0.0, 0.0),
      child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            radius: 18.2,
            child: CircleAvatar(
              backgroundColor: Colors.black87,
              backgroundImage: AssetImage("assets/images/game/logo/${gameName}_logo.png"),
              radius: 18.0,
            ),
          ),
    );
  }
}
