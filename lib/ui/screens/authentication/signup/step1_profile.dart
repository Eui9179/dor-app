import 'dart:io';
import 'dart:async';
import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Step1Profile extends StatefulWidget {
  const Step1Profile({Key? key}) : super(key: key);

  @override
  State<Step1Profile> createState() => _Step1ProfileState();
}

class _Step1ProfileState extends State<Step1Profile> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorPalette.mainBackgroundColor,
        title: const Text(
          "프로필 설정",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: ColorPalette.font),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 15),
        width: double.infinity,
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
                      radius: 70,
                      backgroundColor: Colors.black54,
                      child: _image == null
                          ? Image.asset(
                              "assets/images/logo/dor_default.png",
                              fit: BoxFit.cover,
                            )
                          : CircleAvatar(
                              radius: 75,
                              backgroundImage: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ).image,
                            )),
                  const Positioned(
                    bottom: 9,
                    right: 9,
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
            RoundedButton(btnEnabled: true, onPressed: (){}, text: "다음"),
          ],
        ),
      ),
    );
  }

  Future getImageFromGallery() async {
     await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((image) {
      setState(() {
        _image = image;
      });
    });
  }
}
