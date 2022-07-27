import 'dart:async';

import 'package:dor_app/ui/screens/main_loading_screen.dart';
import 'package:dor_app/ui/static_widget/woojoo_logo_and_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MainLoadingScreen();
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 11, 14, 27),
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/login/login_image.png"),
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
                        stops: [0.0, 0.1, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(top: 40, left: 16, child: WoojooLogoAndName()),
              Positioned(
                  top: 580,
                  left: 20,
                  right: 20,
                  child: OutlinedButton(
                    onPressed: () {
                      _inputPhoneNumber(context);
                    },
                    style: OutlinedButton.styleFrom(
                        fixedSize: const Size(350, 50),
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
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
                        _inputPhoneNumber(context);
                      },
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 2.0, color: Colors.white),
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
  }

  _inputPhoneNumber(context) {
    Get.toNamed('/auth');
  }
}
