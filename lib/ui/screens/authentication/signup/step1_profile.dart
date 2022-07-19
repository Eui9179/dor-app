import 'dart:async';
import 'dart:io';

import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/dynamic_widget/input/outline_input.dart';
import 'package:dor_app/ui/dynamic_widget/input/outline_input_readonly.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/dor_groups.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Step1Profile extends StatefulWidget {
  const Step1Profile({Key? key}) : super(key: key);

  @override
  State<Step1Profile> createState() => _Step1ProfileState();
}

class _Step1ProfileState extends State<Step1Profile> {
  final _formKey = GlobalKey<FormState>();
  final String _phoneNumber = Get.arguments;
  final TextEditingController _typeAheadController = TextEditingController();
  final List<String> _groups = [];
  XFile? _image;
  String? _name;
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
                        labelText: "학교를 입력해주세요",
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 206, 206, 215),
                            fontSize: 20),
                      ),
                      controller: _typeAheadController,
                      onChanged: (val){
                        if(val.isEmpty || !DorGroups.states.contains(val)){
                          setState(() {
                            isGroup = false;
                          });
                        } else if (DorGroups.states.contains(val)){
                          setState(() {
                            _groups.clear(); // 그룹 여러개로 했을 때 지워야됨
                            _groups.add(val);
                            isGroup = true;
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
                        isGroup = true;
                      });
                    }),
                OutlineInputReadOnly(
                  labelText: "전화번호",
                  hintText: _phoneNumber,
                  onTap: () {},
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

  _onPressed() {
    _formKey.currentState!.save();
    if (!DorGroups.states.contains(_groups[0])){
      notification(context, "학교 이름을 확인해주세요!");
    } else {
      Get.toNamed('/auth/signup/step2', arguments: {
        "file": _image,
        "name": _name,
        "groups": _groups,
        "phoneNumber": _phoneNumber,
        "fcmToken": "fcm"
      });
    }
  }

  Future getImageFromGallery() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  String? _listToPrefixText() {
    if (_groups.isEmpty) return null;
    String result = '';
    for (String group in _groups) {
      result += "$group ";
    }
    return result;
  }

// final _items =
//     dorGroups.map((e) => MultiSelectItem<DorGroups>(e, e.name)).toList();
// List<DorGroups> _selectedDorGroups = [];
//
// void _showMultiSelectDialog(BuildContext context) async {
//   await showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     backgroundColor: ColorPalette.mainBackgroundColor,
//     builder: (ctx) {
//       return MultiSelectBottomSheet(
//         title: const Font(
//           text: "학교선택",
//           size: 20,
//         ),
//         cancelText: const Text(
//           "닫기",
//           style: TextStyle(
//               fontSize: 20,
//               color: ColorPalette.font, fontWeight: FontWeight.w300),
//         ),
//         confirmText: const Text("완료",
//             style: TextStyle(
//               fontSize: 20,
//                 color: ColorPalette.font, fontWeight: FontWeight.w300)),
//         listType: MultiSelectListType.CHIP,
//         items: _items,
//         initialValue: _selectedDorGroups,
//         initialChildSize: 0.5,
//         onConfirm: (List<DorGroups> values) {
//           _selectedDorGroups = [...values];
//           List<String> result = [];
//           for (DorGroups value in values) {
//             result.add(value.name);
//           }
//           setState(() {
//             _groups = [...result];
//             if (_groups.isNotEmpty) {
//               isGroup = true;
//             } else {
//               isGroup = false;
//             }
//           });
//         },
//         maxChildSize: 0.8,
//         itemsTextStyle: const TextStyle(fontSize: 15),
//         selectedColor: const Color.fromARGB(205, 57, 113, 255),
//         selectedItemsTextStyle:
//             const TextStyle(fontSize: 15, color: Colors.white),
//       );
//     },
//   );
// }
}
