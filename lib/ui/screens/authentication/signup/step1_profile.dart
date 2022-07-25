import 'dart:async';
import 'dart:io';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:dor_app/ui/dynamic_widget/button/rounded_button.dart';
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
import 'package:permission_handler/permission_handler.dart';

class Step1Profile extends StatefulWidget {
  const Step1Profile({Key? key}) : super(key: key);

  @override
  State<Step1Profile> createState() => _Step1ProfileState();
}

class _Step1ProfileState extends State<Step1Profile> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final String _phoneNumber = Get.arguments;
  final TextEditingController _typeAheadGroupController =
      TextEditingController();
  final TextEditingController _typeAheadDetail1Controller =
      TextEditingController();
  final List<String> _groups = [];
  XFile? _image;
  String? _name;
  String _detail1 = '1';

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
                      _image == null
                          ? CircleAvatar(
                              radius: 55,
                              backgroundImage: Image.asset(
                                "assets/images/logo/default.png",
                                fit: BoxFit.cover,
                              ).image,
                            )
                          : CircleAvatar(
                              radius: 55,
                              backgroundImage: Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ).image,
                            ),
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
                  autoFocus: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: TypeAheadField(
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
                        controller: _typeAheadGroupController,
                        onChanged: (val) {
                          if (val.isEmpty || !DorGroups.states.contains(val)) {
                            setState(() {
                              isGroup = false;
                            });
                          } else if (DorGroups.states.contains(val)) {
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
                        _typeAheadGroupController.text = suggestion.toString();
                        setState(() {
                          _groups.clear();
                          _groups.add(_typeAheadGroupController.text);
                          isGroup = true;
                        });
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 60,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 62, 62, 75),
                      filled: true,
                      labelText: '학년을 입력해주세요',
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 206, 206, 215),
                          fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 52, 52, 71),
                              width: 2)),
                    ),
                    child: DropdownButton<String>(
                        value: _detail1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: ColorPalette.font),
                        isExpanded: true,
                        dropdownColor: ColorPalette.mainBackgroundColor,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _detail1 = newValue!;
                          });
                        },
                        items: _groups.isEmpty || _groups[0].contains("초등학교")
                            ? <String>['1', '2', '3', '4', '5', '6']
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(fontSize: 20)),
                                );
                              }).toList()
                            : <String>['1', '2', '3']
                                .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              }).toList()),
                  ),
                ),
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
    print(_detail1);
    _formKey.currentState!.save();
    if (!DorGroups.states.contains(_groups[0])) {
      notification(context, "학교 이름을 확인해주세요!");
    } else {
      Get.toNamed('/auth/signup/step2', arguments: {
        "file": _image,
        "name": _name,
        "groups": _groups,
        "detail1": _detail1,
        "phoneNumber": _phoneNumber,
        "fcmToken": "fcm"
      });
    }
  }

  Future getImageFromGallery() async {
    var status = await Permission.storage.status;
    if (status.isGranted){
      await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 30)
          .then((image) {
        setState(() {
          _image = image;
        });
      });
    } else if (status.isDenied){
      Permission.storage.request();
    }
  }

  String? _listToPrefixText() {
    if (_groups.isEmpty) return null;
    String result = '';
    for (String group in _groups) {
      result += "$group ";
    }
    return result;
  }
}
