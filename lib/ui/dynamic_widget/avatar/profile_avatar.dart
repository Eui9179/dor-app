import 'package:dor_app/dio/dio_instance.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45.0,
      child: CircleAvatar(
        backgroundImage: image != "default"
            ? NetworkImage('${baseUri}user/profile/image/$image')
            : const AssetImage("assets/images/logo/dor.jpg")
                as ImageProvider,
        radius: 45.0,
      ),
    );
  }
}
