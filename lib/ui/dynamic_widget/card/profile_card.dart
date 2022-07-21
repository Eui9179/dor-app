import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

import '../avatar/profile_avatar.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.image, required this.text})
      : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Card(
            color: ColorPalette.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              height: 150,
            )),
        FractionalTranslation(
          translation: const Offset(0.0, -0.4),
          child: Align(
            alignment: const FractionalOffset(0.5, 0.0),
            child: Column(
              children: [
                ProfileAvatar(
                  image: image,
                ),
                Text(text,
                    style: const TextStyle(fontSize: 30, color: Colors.black87))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
