import 'package:dor_app/main.dart';
import 'package:dor_app/ui/static_widget/dor_logo.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pinput/pinput.dart';
import '../../dynamic_widget/font/font.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key, required this.phoneNumber, required this.type})
      : super(key: key);
  final String phoneNumber;
  final String type;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  _VerificationState({Key? key});

  static final storage = new FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String _verificationCode = "";
  String _smsCode = "";

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
        appBar: AppBar(
          backgroundColor: ColorPalette.mainBackgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: const DorLogo(),
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Font(text: "내 코드 입력", size: 35),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(top: 30),
                      child: Pinput(
                        autofocus: true,
                        length: 6,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 6) {
                            return "코드를 확인해주세요";
                          }
                          return null;
                        },
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) {
                          setState(() {
                            _smsCode = pin;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Font(text: "010 ${widget.phoneNumber}", size: 20),
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
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(400, 50),
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signin();
                        } else {
                          notification(context, '코드를 확인해 주세요');
                        }
                      },
                      child: const Text(
                        "계속",
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _verifyPhone() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: '+82010${widget.phoneNumber}',
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
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  _signin() async {
    try {
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: _smsCode))
          .then((value) {
        // 전화번호로 데이터 베이스 찾고 유저 아이디 저장
        storage.write(key: "isLogin", value: "eui");
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      notification(context, '코드를 확인해 주세요');
    }
  }
}
