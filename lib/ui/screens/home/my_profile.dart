import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/dio/profile/get_my_profile.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/profile_avatar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String? name = "";
  String? profileImageName = "";
  String? phoneNumber = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('_initMyProfile');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initMyProfile();
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ProfileAvatar(
            image: profileImageName,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(name!,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.font)),
        ]),
      );
    }
  }

  _initMyProfile() {
    final String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response = dioApiGetMyProfile(accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Map<String, dynamic> profileData = res["data"];
        setState(() {
          name = profileData["name"];
          profileImageName = profileData["profile_image_name"];
          phoneNumber = profileData["phone_number"];
          isLoading = false;
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      } else {
        print("_getMyProfile() error: $statusCode");
      }
    });

  }
}
