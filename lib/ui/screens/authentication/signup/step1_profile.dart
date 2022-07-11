import 'dart:io';
import 'dart:async';
import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
import 'package:dor_app/ui/dynamic_widget/input/outline_input.dart';
import 'package:dor_app/ui/dynamic_widget/input/outline_input_readonly.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/ui/screens/authentication/signup/step2_tos.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/page_route_animation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Step1Profile extends StatefulWidget {
  final String phoneNumber;

  const Step1Profile({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Step1Profile> createState() => _Step1ProfileState();
}

class _Step1ProfileState extends State<Step1Profile> {
  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  String? _name;
  String? _group;
  bool isName = false;
  bool isGroup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: const TextAppBar(title: "프로필 설정"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.black54,
                          child: _image == null
                              ? Image.asset(
                                  "assets/images/logo/dor_default.png",
                                  fit: BoxFit.cover,
                                )
                              : CircleAvatar(
                                  radius: 55,
                                  backgroundImage: Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                  ).image,
                                )),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlineInput(
                  onSaved: (val) {
                    setState(() {
                      _name = val;
                    });
                  },
                  onChanged: (val) {
                    if (val != null && val.isNotEmpty) {
                      setState(() {
                        isName = true;
                      });
                    }
                  },
                  validator: (val) {
                    return null;
                  },
                  labelText: "이름을 입력해주세요",
                ),
                OutlineInput(
                  onSaved: (val) {
                    setState(() {
                      _group = val;
                    });
                  },
                  onChanged: (val) {
                    if (val != null && val.isNotEmpty) {
                      setState(() {
                        isGroup = true;
                      });
                    }
                  },
                  validator: (val) {
                    return null;
                  },
                  labelText: "소속을 입력해주세요(학교, 회사, 지역 등)",
                ),
                const OutlineInputReadOnly(
                  hintText: "+8201026649179",
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundedButton(
                    btnEnabled: (isName && isGroup),
                    onPressed: _onPressed,
                    text: "다음"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImageFromGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  _onPressed() {
    _formKey.currentState!.save();
    Map data = _mappedData(_image, _name!, _group!, widget.phoneNumber);
    PageRouteWithAnimation pageRouteWithAnimation =
        PageRouteWithAnimation(Step2TOS(profileData: data));
    Navigator.push(context, pageRouteWithAnimation.slideRitghtToLeft());
  }

  Map _mappedData(XFile? image, String name, String group, String phoneNumber) {
    return {
      "file": image,
      "name": name,
      "group": group,
      "phoneNumber": phoneNumber,
      "fcmToken": "fcm"
    };
  }
}
