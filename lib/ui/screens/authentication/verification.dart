import 'package:dio/dio.dart';
import 'package:dor_app/dio/auth/login.dart';
import 'package:dor_app/main.dart';
import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
import 'package:dor_app/ui/layout/app_bar/logo_app_bar.dart';
import 'package:dor_app/ui/screens/authentication/signup/step1_profile.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../utils/page_route_animation.dart';
import '../../dynamic_widget/font/font.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  _VerificationState({Key? key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String _verificationCode = "";
  String _smsCode = "";
  bool btnEnabled = false;

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 25,
          color: Color.fromRGBO(255, 255, 255, 1.0),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Color.fromRGBO(168, 168, 168, 1.0), width: 3.0)),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: const Border(
          bottom:
              BorderSide(color: Color.fromRGBO(234, 239, 243, 1), width: 3.0)),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(),
    );

    return Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        appBar: const LogoAppBar(),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Font(text: "내 코드 입력", size: 35),
              const SizedBox(
                height: 5,
              ),
              const Font(text: "메세지 도착까지 최대 1분정도 소요됩니다.", size: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 30),
                      child: Pinput(
                        length: 6,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 6) {
                            return "코드를 확인해주세요";
                          }
                          return null;
                        },
                        onCompleted: (pin) {
                          setState(() {
                            _smsCode = pin;
                          });
                        },
                        onChanged: (val) {
                          val.length == 6
                              ? setState(() => btnEnabled = true)
                              : setState(() => btnEnabled = false);
                        },
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        autofocus: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Font(text: widget.phoneNumber, size: 20),
                        TextButton(
                          onPressed: () {
                            _verifyPhone();
                          },
                          child: const Text(
                            "재전송",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                        btnEnabled: btnEnabled,
                        onPressed: _onPressed,
                        text: "계속"),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _verifyPhone() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  _onPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithCredential(PhoneAuthProvider.credential(
                verificationId: _verificationCode, smsCode: _smsCode))
            .then((value) {
          Future<dynamic> response = dioApiLogin(widget.phoneNumber);
          response.then((result) {
            // TODO: fcm 키 처리
            if (result == 401) {
              _signup();
            } else {
              _signin(result);
            }
          }).catchError((error) {});
        });
      } catch (e) {
        FocusScope.of(context).unfocus();
        notification(context, '코드를 확인해 주세요');
      }
    }
  }

  _signup() {
    PageRouteWithAnimation pageRouteWithAnimation =
        PageRouteWithAnimation(Step1Profile(
      phoneNumber: widget.phoneNumber,
    ));
    Navigator.push(context, pageRouteWithAnimation.slideRitghtToLeft());
  }

  _signin(String accessToken) async {
    storage.write(key: "accessToken", value: accessToken);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
        (route) => false);
  }
}
