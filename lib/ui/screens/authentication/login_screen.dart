import 'package:dor_app/ui/screens/authentication/input_phone_number.dart';
import 'package:dor_app/ui/static_widget/dor_logo_and_name.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorPalette.mainBackgroundColor,
    ));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/login/leagueoflegends.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 0, 0, 0),
                        Colors.transparent,
                        Colors.transparent,
                        Color.fromARGB(255, 0, 0, 0),
                      ],
                      stops: [0.0, 0.5, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(top: 40, left: 13, child: DorLogoAndName()),
            const Positioned(
                top: 250,
                left: 80,
                right: 80,
                child: Text(
                  "내 주변 게이머를 찾아보세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: ColorPalette.font),
                )),
            Positioned(
                top: 580,
                left: 20,
                right: 20,
                child: OutlinedButton(
                  onPressed: () {
                    _login(context);
                  },
                  style: OutlinedButton.styleFrom(
                      fixedSize: const Size(350, 50),
                      primary: Colors.black,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  child: const Text(
                    "로그인",
                    style: TextStyle(fontSize: 23),
                  ),
                )),
            Positioned(
                top: 650,
                left: 20,
                right: 20,
                child: OutlinedButton(
                    onPressed: () {
                      _signup(context);
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 2.0, color: Colors.white),
                        fixedSize: const Size(50, 50),
                        primary: Colors.white,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    child: const Text(
                      "계정 만들기",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ))),
          ],
        ));
  }

  _login(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const InputPhoneNumber(type: "login")),
    );
  }

  _signup(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const InputPhoneNumber(type: "signup")),
    );
  }
}
