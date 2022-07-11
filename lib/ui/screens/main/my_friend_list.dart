import 'package:dio/dio.dart';
import 'package:dor_app/dio/friend/get_my_friend_list.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/friend_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/dynamic_widget/icon_button/more_icon_button.dart';
import 'package:dor_app/ui/dynamic_widget/icon_button/send_icon_button.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:flutter/material.dart';

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
  late String? _accessToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAccessTokenAndMyFriendList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              SubjectTitle(title: "내 게임 친구"),
              Row(
                children: [
                  SubjectTitle(title: _myFriendList.length.toString()),
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: () => {},
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
                    const Font(text: "내연락처를 ", size: 20),
                    InkWell(
                        onTap: () {}, // TODO: 동기화 하기
                        child: const Text("동기화",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ))),
                    const Font(text: " 해보세요!", size: 20),
                  ],
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemExtent: 65.0,
                // 아이템간 간격
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userSet.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: FriendAvatar(),
                      title: Font(text: userSet[index]["nickname"], size: 17),
                      subtitle:
                          Font(text: userSet[index]["introduction"], size: 13),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SendIconButton(onPressed: () => {}),
                          const SizedBox(
                            width: 5,
                          ),
                          MoreIconButton(onPressed: () => {}),
                        ],
                      ));
                }),
      ],
    );
  }

  _getAccessTokenAndMyFriendList() async {
    _accessToken = await storage.read(key: "accessToken");
    _getMyFriendList();
  }

  _getMyFriendList() {
    Future<dynamic> response = dioApiGetMyFriendList(_accessToken);
    response.then((myFriendList) {
      setState(() {
        _myFriendList = myFriendList;
      });
    }).catchError((error) {
      print("_getMyFriendList error: $error");
    });
  }
}
