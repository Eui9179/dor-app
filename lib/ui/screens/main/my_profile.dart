import 'package:dio/dio.dart';
import 'package:dor_app/dio/profile/get_my_profile.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/profile_avatar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late final String? _accessToken;
  String? name = "";
  String? profileImageName = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAccessToken();
    });
  }

  _getAccessToken() async {
    _accessToken = await storage.read(key: "accessToken");
    Map<String, String> response = await getMyProfile(_accessToken);
    // print(response);
    setState(() {
      name = response["name"];
      profileImageName = response["profileImageName"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Text("loading..."),
      );
    } else {
      return Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 15, left: 15, bottom: 25, right: 15),
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
            image: profileImageName,
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
}
