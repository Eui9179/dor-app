import 'package:dor_app/ui/dynamic_widget/card/game_card.dart';
import 'package:dor_app/ui/dynamic_widget/font/subject_title.dart';
import 'package:flutter/material.dart';

class UserGames extends StatelessWidget {
  const UserGames({Key? key, required this.userGames, required this.userName})
      : super(key: key);
  final List<dynamic> userGames;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubjectTitle(title: "$userName 님의 게임 목록"),
          ],
        ),
      ),
      userGames.isNotEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 5.0, left: 13),
              height: 230.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userGames.length,
                itemBuilder: (BuildContext context, int index) {
                  return GameCard(gameName: userGames[index]['game'], isMe: false, nickname: userGames[index]['nickname'],);
                },
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 100.0,
              child: const Center(
                    child: Text("등록된 게임이 없습니다",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.blueAccent,
                        )),
                  ),

            ),
    ]);
  }
}

// class MyGames extends StatefulWidget {
//   const MyGames({Key? key}) : super(key: key);
//
//   @override
//   State<MyGames> createState() => _MyGamesState();
// }
//
// class _MyGamesState extends State<MyGames> {
//   late final String? _accessToken;
//   List<dynamic> _userGameList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initMyGameList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 13.0, right: 13.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SubjectTitle(title: "내 게임 목록"),
//             InkWell(
//               onTap: () {},
//               child: const SizedBox(
//                 height: 20,
//                 width: 30,
//                 child: Text(
//                   "편집",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 172, 172, 172),
//                       fontSize: 15,
//                       decoration: TextDecoration.underline),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       _userGameList.isNotEmpty
//           ? Container(
//         margin: const EdgeInsets.only(top: 5.0, left: 13),
//         height: 230.0,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: _userGameList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GameCard(gameName: _userGameList[index]);
//           },
//         ),
//       )
//           : Container(
//         margin: const EdgeInsets.symmetric(vertical: 5.0),
//         height: 120.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//                 onTap: () {
//                   Get.toNamed('/setting/games');
//                 },
//                 child: const Text("게임등록",
//                     style: TextStyle(
//                       fontSize: 22,
//                       color: Colors.blueAccent,
//                       decoration: TextDecoration.underline,
//                     ))),
//             const Font(text: "을 해보세요!", size: 18),
//           ],
//         ),
//       ),
//     ]);
//   }
// }
