import 'package:dor_app/ui/static_widget/dor_logo.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:dor_app/utils/page_route_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../dynamic_widget/font/font.dart';
import 'verification.dart';

class InputPhoneNumber extends StatefulWidget {
  final String type;
  const InputPhoneNumber({Key? key, required this.type}) : super(key: key);

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  var _phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    const enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
    const focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
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
              const Font(text: "내 전화번호", size: 35),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 8) {
                            return "전화 번호 8자리 입력";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            _phoneNumber = val!;
                          });
                        },
                        style: const TextStyle(
                            fontSize: 30.0, height: 2.0, color: Colors.white),
                        decoration: const InputDecoration(
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          prefixStyle:
                              TextStyle(color: Colors.white, fontSize: 30),
                          prefixText: "010 ",
                          errorStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Text(
                      "로그인 및 회원가입을 하면 DOR 이용약관에 동의하는 것으로 간주 됩니다. "
                      "DOR의 회원 정보 처리방식은 개인정보 처리 방침 및 쿠키 정책을 확인해 보세요. "
                      "계속하기를 누르면 인증코드를 문자 메세지로 전송합니다. "
                      "인증이 완료된 전화번호는 dOR에 로그인 할 수 있습니다.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(400, 50),
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          PageRouteWithAnimation pageRouteWithAnimation =
                              PageRouteWithAnimation(
                                  Verification(phoneNumber: _phoneNumber, type: widget.type,));
                          Navigator.push(context,
                              pageRouteWithAnimation.slideRitghtToLeft());
                        } else {
                          notification(context, "전화번호를 확인해 주세요");
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
}
