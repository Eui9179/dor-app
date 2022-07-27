import 'package:dor_app/ui/static_widget/woojoo_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainLoadingScreen extends StatelessWidget {

  const MainLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
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
            const Positioned(top: 50, left: 16, child: WoojooLogo ()),
          ],
        ));
  }
}
