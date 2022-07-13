import 'package:dio/dio.dart';
import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/ui/screens/authentication/signup/step3_game.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/page_route_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../dio/auth/signup.dart';
import '../../../../main.dart';
import '../../../../utils/notification.dart';

class Step2TOS extends StatefulWidget {
  const Step2TOS({Key? key, required this.profileData}) : super(key: key);
  final Map profileData;

  @override
  State<Step2TOS> createState() => _Step2TOSState();
}

class _Step2TOSState extends State<Step2TOS> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: const TextAppBar(title: "약관 동의"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: _onTapTOSLaunch,
                    child: const Font(text: "이용 약관 동의", size: 20)),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                      value: _isChecked1,
                      checkColor: Colors.white,
                      activeColor: Colors.blueAccent,
                      onChanged: (val) {
                        setState(() {
                          _isChecked1 = val!;
                        });
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: _onTapTOSLaunch,
                    child: const Font(text: "데이터 정책 동의", size: 20)),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                      value: _isChecked2,
                      checkColor: Colors.white,
                      activeColor: Colors.blueAccent,
                      onChanged: (val) {
                        setState(() {
                          _isChecked2 = val!;
                        });
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: _onTapTOSLaunch,
                    child: const Font(text: "개인정보 수집 동의", size: 20)),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                      value: _isChecked3,
                      checkColor: Colors.white,
                      activeColor: Colors.blueAccent,
                      onChanged: (val) {
                        setState(() {
                          _isChecked3 = val!;
                        });
                      }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: _onTapTOSLaunch,
                    child: const Font(text: "쿠키 약관 동의", size: 20)),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                      value: _isChecked4,
                      checkColor: Colors.white,
                      activeColor: Colors.blueAccent,
                      onChanged: (val) {
                        setState(() {
                          _isChecked4 = val!;
                        });
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(
              btnEnabled:
                  (_isChecked1 && _isChecked2 && _isChecked3 && _isChecked4),
              onPressed: _onPressed,
              text: "다음",
            )
          ],
        ),
      ),
    );
  }

  _onPressed() {
    Future<Map<String, dynamic>> response = dioApiSignup(widget.profileData);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200){
        storage.write(key: "accessToken", value: res["data"]);
        PageRouteWithAnimation pageRouteWithAnimation =
        PageRouteWithAnimation(const Step3Game());
        Navigator.pushAndRemoveUntil(context,
            pageRouteWithAnimation.slideRitghtToLeft(), (route) => false);
      } else if (statusCode == 409){
        notification(context, "이미 가입된 회원입니다. 로그인해주세요");
      } else if (statusCode == 500){
        notification(context, "죄송합니다. 다시 실행시켜주세요");
      }

    });
  }

  void _onTapTOSLaunch() => launchUrl(Uri.parse('https://dor.gg/policy'));
}
