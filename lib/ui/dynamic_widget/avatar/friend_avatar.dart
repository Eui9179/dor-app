import 'package:dor_app/dio/dio_instance.dart';
import 'package:flutter/material.dart';

class FriendAvatar extends StatelessWidget {
  const FriendAvatar({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
          width: 55,
          height: 55,
          color: Colors.black54,
          child: image == "default"
              ? Image.asset('assets/images/logo/default.png',
                  fit: BoxFit.cover)
              : Image.network('$cdnProfileImageBaseUri$image',
                  fit: BoxFit.cover)),
    );
  }
}
