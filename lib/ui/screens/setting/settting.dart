import 'dart:async';
import 'dart:io';

import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_groups_controller.dart';
import 'package:dor_app/controller/my_profile_controller.dart';
import 'package:dor_app/dio/auth/withdrawal.dart';
import 'package:dor_app/dio/dio_instance.dart';
import 'package:dor_app/dio/profile/update_my_profile.dart';
import 'package:dor_app/main.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/dor_groups.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  final List<String> _groups = [];
  XFile? _image;
  String? _name;
  String _originImage = '';
  bool _isName = true;
  bool _isGroup = true;
  bool _isFile = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //TODO: 현재는 그룹 한개만
    _typeAheadController.text = Get.find<MyGroupsController>().groups[0];
    _name = Get.find<MyProfileController>().name;
    _originImage = Get.find<MyProfileController>().profileImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorPalette.mainBackgroundColor,
        title: const Text(
          '설정',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: ColorPalette.font),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: _onUpdateProfile,
              child: _isLoading
                  ? const Text(
                      '완료',
                      style:
                          TextStyle(color: ColorPalette.subFont, fontSize: 22),
                    )
                  : const Text(
                      '완료',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 22),
                    ))
        ],
      ),
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
                              ? _originImage == 'default'
                                  ? const CircleAvatar(
                                      backgroundImage: AssetImage(
                                        "assets/images/logo/default.png",
                                      ),
                                      radius: 55,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          '$cdnProfileImageBaseUri$_originImage'),
                                      radius: 55.0,
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
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _name,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.always,
                        onSaved: (val) {
                          print('onSaved: $val');
                          setState(() {
                            _name = val;
                          });
                        },
                        onChanged: (val) {
                          print('onChanged: $val');
                          if (val.isEmpty) {
                            setState(() {
                              _isName = false;
                            });
                          } else {
                            setState(() {
                              _isName = true;
                            });
                          }
                        },
                        validator: (val) {
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 20.0, color: ColorPalette.font),
                        decoration: InputDecoration(
                          fillColor: const Color.fromARGB(255, 62, 62, 75),
                          filled: true,
                          labelText: '이름',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 206, 206, 215),
                              fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 52, 52, 71),
                                  width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                          fontSize: 20.0, color: ColorPalette.font),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 52, 52, 71),
                                width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 2)),
                        fillColor: const Color.fromARGB(255, 62, 62, 75),
                        filled: true,
                        labelText: "학교",
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 206, 206, 215),
                            fontSize: 20),
                      ),
                      controller: _typeAheadController,
                      onChanged: (val) {
                        if (val.isEmpty || !DorGroups.states.contains(val)) {
                          setState(() {
                            _isGroup = false;
                          });
                        } else if (DorGroups.states.contains(val)) {
                          setState(() {
                            _groups.clear(); // 그룹 여러개로 했을 때 지워야됨
                            _groups.add(val);
                            _isGroup = true;
                          });
                        }
                      },
                    ),
                    suggestionsCallback: (pattern) {
                      return DorGroups.getSuggestions(pattern);
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.toString()),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _typeAheadController.text = suggestion.toString();
                      setState(() {
                        _groups.clear();
                        _groups.add(_typeAheadController.text);
                        _isGroup = true;
                      });
                    }),
                const SizedBox(
                  height: 80,
                ),
                TextButton(
                    onPressed: _onLogout,
                    child: const Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 22),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      _showTextInputDialog(context);
                    },
                    child: const Text(
                      '회원탈퇴',
                      style: TextStyle(
                          color: ColorPalette.subFont,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onUpdateProfile() {
    setState(() {
      _isLoading = true;
    });
    if (_isName && _isGroup) {
      _formKey.currentState!.save();
      String accessToken = Get.find<AccessTokenController>().accessToken;
      Map profileData = {
        'isFile': _isFile,
        'file': _image,
        'name': _name,
        'groups': [_typeAheadController.text]
      };
      Future<Map<String, dynamic>> response =
          dioApiUpdateMyProfile(profileData, accessToken);
      response.then((res) {
        setState(() {
          _isLoading = false;
        });
        int statusCode = res["statusCode"];
        if (statusCode == 200) {
          Get.find<MyProfileController>().setMyName(_name!);
          Get.find<MyGroupsController>()
              .setMyGroups([_typeAheadController.text]);
          Get.find<MyProfileController>().setMyProfileImage(res['data']);
          notification(context, '저장 완료!', warning: false);
        } else if (statusCode == 401) {
          notification(context, "다시 로그인 해주세요");
        } else {
          notification(context, statusCode.toString());
        }
      });
    } else if (!_isName) {
      notification(context, '이름을 입력해주세요');
    } else if (!_isGroup) {
      notification(context, '소속을 입력해주세요');
    }
  }

  _onLogout() {
    storage.delete(key: "accessToken");
    Get.offAllNamed('/login');
  }

  _onWithdrawal() {
    String accessToken = Get.find<AccessTokenController>().accessToken;
    Future<Map<String, dynamic>> response = dioApiWithdrawal(accessToken);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        storage.delete(key: "accessToken");
        Get.offAllNamed('/login');
      } else {
        notification(context, '죄송합니다. 다시 실행시켜주세요[$statusCode]');
      }
    });
  }

  Future getImageFromGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 30).then((image) {
      setState(() {
        _image = image;
        if (image == null) {
          _originImage = 'default';
        }
        _isFile = true;
      });
    });
  }

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: ColorPalette.mainBackgroundColor,
            contentPadding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: SizedBox(
              height: 65,
              child: Column(
                children: const [
                  Text(
                    '회원 탈퇴',
                    style: TextStyle(color: ColorPalette.font, fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '회원탈퇴시 저장되어 있는 \n모든 데이터가 삭제됩니다',
                    style: TextStyle(color: ColorPalette.subFont, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    '취소',
                    style: TextStyle(color: ColorPalette.font, fontSize: 20),
                  )),
              TextButton(
                  onPressed: () {
                    _onWithdrawal();
                  },
                  child: const Text(
                    '완료',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  )),
            ],
          );
        });
  }
}
