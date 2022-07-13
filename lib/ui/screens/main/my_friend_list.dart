import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:dor_app/dio/friend/get_my_friend_list.dart';
import 'package:dor_app/dio/friend/update_my_friend_list.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/friend_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/game_logo_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/dynamic_widget/icon_button/more_icon_button.dart';
import 'package:dor_app/ui/dynamic_widget/icon_button/send_icon_button.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:dor_app/utils/sync_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../main.dart';

/*
* 1. 서버로부터 내 친구 목록 가져오기
* 이미 친구가 있다면 친구 목록 + 동기화 버튼
* 없다면
* 1`. 동기화하라는 문구
* 2`. 문구 클릭시 내 연락처 모두 가져오기
* 3`. 서버로 전송 */

const userSet = [
  {"nickname": "이의찬", "introduction": "안녕하세요"},
  {"nickname": "전상순", "introduction": "안녕하세요"},
  {"nickname": "삼사원", "introduction": "안녕하세요"},
  {"nickname": "지홍찬", "introduction": "안녕하세요"},
  {"nickname": "박주혁", "introduction": "안녕하세요"},
];

class MyFriendList extends StatefulWidget {
  const MyFriendList({Key? key}) : super(key: key);

  @override
  State<MyFriendList> createState() => _MyFriendListState();
}

class _MyFriendListState extends State<MyFriendList> {
  List<dynamic> _myFriendList = [];
  List<String?> _myContacts = [];
  late String? _accessToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initMyFriendList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> myFriends = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SubjectTitle(title: "내 게임 친구"),
              Row(
                children: [
                  SubjectTitle(title: _myFriendList.length.toString()),
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: () => {_syncContacts()},
                      tooltip: "친구 동기화",
                      padding: EdgeInsets.zero,
                      // 패딩 삭제
                      constraints: const BoxConstraints(),
                      // 패딩 삭제
                      splashRadius: 20,
                      icon: const Icon(Icons.refresh_sharp,
                          color: ColorPalette.font, size: 22)),
                  const SizedBox(width: 10)
                ],
              )
            ],
          ),
        ),
        _myFriendList.isEmpty
            ? Container(
                height: 40,
                margin: const EdgeInsets.only(top: 35),
                width: double.infinity,
                child: Row(
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    const Font(text: "내연락처를 ", size: 18),
                    InkWell(
                        onTap: () {
                          _syncContacts();
                        },
                        child: const Text("동기화",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ))),
                    const Font(text: " 해보세요!", size: 18),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemExtent: 65.0,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _myFriendList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: FriendAvatar(
                        image: _myFriendList[index]["profile_image_name"]),
                    title: Font(text: _myFriendList[index]["name"], size: 17),
                    subtitle: Font(text: _myFriendList[index]["name"], size: 10),
                    onTap: () {},
                  );
                }),
      ],
    );
  }

  _initMyFriendList() async {
    _accessToken = await storage.read(key: "accessToken");
    _getMyFriendList();
  }

  _getMyFriendList() {
    Future<dynamic> response = dioApiGetMyFriendList(_accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        setState(() {
          _myFriendList = res["data"];
        });
      } else if (statusCode == 401) {
        notification(context, "다시 로그인 해주세요");
      } else {
        print("_getMyFriendList() error: $statusCode");
      }
    });
  }

  _syncContacts() async {
    var status = await Permission.contacts.status;
    List<String?> myContacts = [];

    if (status.isGranted) {
      var contacts = await ContactsService.getContacts();
      for (var contact in contacts) {
        if (contact.phones!.isNotEmpty) {
          myContacts.add(contact.phones!.first.value);
        }
      }
      _myContacts = formattedContacts(myContacts);
      Future<Map<String, dynamic>> response =
          dioApiUpdateMyFriendList(_accessToken, _myContacts);
      response.then((res) {
        int statusCode = res["statusCode"];
        if (statusCode == 200) {
          notification(context, "동기화 완료!", warning: false);
          _getMyFriendList();
        } else if (statusCode == 401) {
          notification(context, "다시 로그인 해주세요");
        } else {
          print(statusCode);
        }
      });
    } else if (status.isDenied) {
      Permission.contacts.request();
    }
  }

  _setState() {
    setState(() {});
  }
}
