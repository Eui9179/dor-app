import 'package:dor_app/ui/dynamic_widget/avatar/friend_avatar.dart';
import 'package:dor_app/ui/dynamic_widget/font/font.dart';
import 'package:dor_app/ui/dynamic_widget/icon_button/more_icon_button.dart';
import 'package:dor_app/ui/dynamic_widget/icon_button/send_icon_button.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:dor_app/ui/static_widget/dor_avatar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class MyFriendList extends StatelessWidget {
  const MyFriendList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubjectTitle(title: "게임 친구"),
              Row(
                children: [
                  SubjectTitle(title: "30명"),
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: () => {},
                      tooltip: "친구 동기화",
                      padding: EdgeInsets.zero,
                      // 패딩 삭제
                      constraints: const BoxConstraints(),
                      // 패딩 삭제
                      splashRadius: 20,
                      icon: const Icon(Icons.person_add,
                          color: ColorPalette.font, size: 22)),
                  const SizedBox(width: 10)
                ],
              )
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemExtent: 65.0, // 아이템간 간격
            physics: NeverScrollableScrollPhysics(),
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
                      SizedBox(
                        width: 5,
                      ),
                      MoreIconButton(onPressed: () => {}),
                    ],
                  ));
            }),
      ],
    );
  }
}

const userSet = [
  {"nickname": "이의찬", "introduction": "안녕하세요"},
  {"nickname": "전상순", "introduction": "안녕하세요"},
  {"nickname": "삼사원", "introduction": "안녕하세요"},
  {"nickname": "지홍찬", "introduction": "안녕하세요"},
  {"nickname": "박주혁", "introduction": "안녕하세요"},
];
