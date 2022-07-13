import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/dor_games.dart';
import 'package:flutter/material.dart';

class GameLogoAvatar extends StatelessWidget {
  const GameLogoAvatar({Key? key, required this.gameName}) : super(key: key);
  final String gameName;

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: CircleAvatar(
            backgroundColor: ColorPalette.mainBackgroundColor,
            radius: 15,
            child: CircleAvatar(
              backgroundColor: Colors.black87,
              backgroundImage: AssetImage("assets/images/game/logo/${gameName}_logo.png"),
              radius: 12.0,
            ),
          ),
    );
  }
}
