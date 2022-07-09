import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/ui/screens/authentication/signup/step3_game.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/page_route_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Step2TOS extends StatefulWidget {
  const Step2TOS({Key? key, required this.profileData}) : super(key: key);
  final Map profileData;

  @override
  State<Step2TOS> createState() => _Step2TOSState();
}

class _Step2TOSState extends State<Step2TOS> {
  static const storage = FlutterSecureStorage();
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        appBar: TextAppBar(title: "약관 동의"),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Font(text: "약관 동의1", size: 15),
                Checkbox(
                    value: _isChecked1,
                    onChanged: (val) {
                      setState(() {
                        _isChecked1 = val!;
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Font(text: "약관 동의2", size: 15),
                Checkbox(
                    value: _isChecked2,
                    onChanged: (val) {
                      setState(() {
                        _isChecked2 = val!;
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Font(text: "약관 동의3", size: 15),
                Checkbox(
                    value: _isChecked3,
                    onChanged: (val) {
                      setState(() {
                        _isChecked3 = val!;
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Font(text: "약관 동의4", size: 15),
                Checkbox(
                    value: _isChecked4,
                    onChanged: (val) {
                      setState(() {
                        _isChecked4 = val!;
                      });
                    }),
              ],
            ),
            RoundedButton(
              btnEnabled:
                  (_isChecked1 && _isChecked2 && _isChecked3 && _isChecked4),
              onPressed: _onPressed,
              text: "다음",
            )
          ],
        ));
  }
  _onPressed(){
    // TODO: 동의시, 회원가입 처리
    // TODO: widget.profileData 서버로 보내기 -> 회원가입 후 user id 받아와서 storage 저장
    storage.write(key: "isLogin", value: "eui");
    PageRouteWithAnimation pageRouteWithAnimation =
    PageRouteWithAnimation(const Step3Game());
    Navigator.pushAndRemoveUntil(
        context,
        pageRouteWithAnimation.slideRitghtToLeft(),
            (route) => false);
  }

}
