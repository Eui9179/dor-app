import 'package:contacts_service/contacts_service.dart';
import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_friends_controller.dart';
import 'package:dor_app/dio/friend/get_my_friends.dart';
import 'package:dor_app/dio/friend/sync_my_friends.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/friend_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/avatar/game_logo_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:dor_app/utils/sync_contacts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MyFriends extends StatefulWidget {
  const MyFriends({Key? key}) : super(key: key);

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> {
  List<dynamic> _myFriends = Get.find<MyFriendsController>().myFriends;
  List<String?> _myContacts = [];
  late String? _accessToken;

  @override
  void initState() {
    super.initState();
    _initMyFriendList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyFriendsController>(
      builder: (controller){
        _myFriends = controller.myFriends;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 13.0, left: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SubjectTitle(title: "내 게임 친구"),
                  Row(
                    children: [
                      SubjectTitle(title: '${_myFriends.length.toString()} 명'),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () => {_syncContacts()},
                          tooltip: "친구 동기화",
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 20,
                          icon: const Icon(Icons.refresh_sharp,
                              color: ColorPalette.font, size: 22)),
                    ],
                  )
                ],
              ),
            ),
            _myFriends.isEmpty
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
                itemExtent: 75.0,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _myFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 13.0, left: 13.0),
                      child: Row(
                        children: [
                          FriendAvatar(
                              image: _myFriends[index]["profile_image_name"]),
                          const SizedBox(
                            width: 13,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Font(text: _myFriends[index]["name"], size: 18),
                              _myFriends[index]['games'].length != 0
                                  ? const SizedBox(
                                height: 8,
                              )
                                  : const SizedBox(),
                              _myFriends[index]['games'].length != 0
                                  ? Row(
                                children: [
                                  if (_myFriends[index]['games'].length ==
                                      1) ...[
                                    GameLogoAvatar(
                                        gameName: _myFriends[index]
                                        ['games'][0]),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const SubjectTitle(
                                        title: "함께 하는 게임 1개")
                                  ],
                                  if (_myFriends[index]['games'].length >
                                      1) ...[
                                    SizedBox(
                                      width: 52,
                                      child: Stack(children: [
                                        Positioned(
                                            left: 18,
                                            child: GameLogoAvatar(
                                                gameName:
                                                _myFriends[index]
                                                ['games'][1])),
                                        Positioned(
                                            child: GameLogoAvatar(
                                                gameName:
                                                _myFriends[index]
                                                ['games'][0])),
                                      ]),
                                    ),
                                    SubjectTitle(
                                        title:
                                        "함께 하는 게임 ${_myFriends[index]['games'].length}개")
                                  ]
                                ],
                              )
                                  : const SizedBox()
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        );
      },

    );
  }

  _initMyFriendList() {
    _accessToken = Get.find<AccessTokenController>().accessToken;
    _getMyFriendList();
  }

  _getMyFriendList() async {
    Future<dynamic> response = dioApiGetMyFriends(_accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Get.find<MyFriendsController>().setMyFriends(res['data']);
      } else if (statusCode == 401) {
        notification(context, '다시 로그인 해주세요');
      } else {
        print('_getMyFriendList() error: $statusCode');
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
          dioApiSyncMyFriendsiends(_accessToken, _myContacts);
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
}
