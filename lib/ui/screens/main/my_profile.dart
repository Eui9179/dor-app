import 'package:dor_app/ui/dynamic_widget/avatar/profile_avatar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30, left: 15, bottom: 25, right: 15),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            ColorPalette.headerBackgroundColor,
            ColorPalette.mainBackgroundColor
          ],
              stops: [
            0.4,
            0.4
          ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ProfileAvatar(
          image: "assets/images/test.jpg",
        ),
        SizedBox(
          height: 15,
        ),
        Text("이의찬",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: ColorPalette.font)),
      ]),
    );
  }
}
