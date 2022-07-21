import 'package:dor_app/ui/static_widget/dividing_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dynamic_widget/button/group_text_button.dart';

class UserGroups extends StatelessWidget {
  const UserGroups({Key? key, required this.userGroups}) : super(key: key);
  final List<dynamic> userGroups;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 13, bottom: 15, right: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemExtent: 28.0,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userGroups.length,
              itemBuilder: (BuildContext context, int index) {
                return GroupTextButton(
                  text: userGroups[index],
                  onTap: () {
                    Get.toNamed("/group/detail?name=${userGroups[index]}");
                  },
                );
              }),
          const SizedBox(height: 5,),
          const DividingLine()
        ],
      ),
    );
  }
}


// class UserGroups extends StatefulWidget {
//   const UserGroups({Key? key, required this.userGroups}) : super(key: key);
//   final List<dynamic> userGroups;
//
//
//   @override
//   State<UserGroups> createState() => _UserGroupsState();
// }
//
// class _UserGroupsState extends State<UserGroups> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 13, bottom: 15, right: 13),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ListView.builder(
//               shrinkWrap: true,
//               itemExtent: 28.0,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.userGroups.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GroupTextButton(
//                   text: widget.userGroups[index],
//                   onTap: () {
//                     Get.toNamed("/group/detail?name=${widget.userGroups[index]}");
//                   },
//                 );
//               }),
//           const SizedBox(height: 5,),
//           const DividingLine()
//         ],
//       ),
//     );
//   }
// }
