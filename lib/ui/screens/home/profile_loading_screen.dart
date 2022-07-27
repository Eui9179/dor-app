import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ProfileLoadingScreen extends StatelessWidget {
  const ProfileLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorPalette.headerBackgroundColor,
      ),
      body: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 15, bottom: 20, right: 13, left: 13),
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
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 45.0,
              ),
              SizedBox(
                height: 15,
              ),
              Text('',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.font)),
            ]),
      ),
    );
  }
}
