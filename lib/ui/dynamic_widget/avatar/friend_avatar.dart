import 'package:dor_app/dio/dio_instance.dart';
import 'package:flutter/material.dart';

class FriendAvatar extends StatelessWidget {
  const FriendAvatar({Key? key, required this.image}) : super(key: key);
  final image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
          width: 60,
          height: 60,
          color: Colors.black54,
          child: image == "default"
              ? Image.asset('assets/images/logo/dor_default.png',
                  fit: BoxFit.cover)
              : Image.network('$baseUri/user/profile/image/$image',
                  fit: BoxFit.cover)),
    );
  }
}
