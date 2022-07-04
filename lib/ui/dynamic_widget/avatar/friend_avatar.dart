import 'package:flutter/material.dart';

class FriendAvatar extends StatelessWidget {
  const FriendAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
          width: 40,
          height: 40,
          color: Colors.black,
          child: Image.asset('assets/images/logo/dor_default.png', fit: BoxFit.cover)),
    );
  }
}
