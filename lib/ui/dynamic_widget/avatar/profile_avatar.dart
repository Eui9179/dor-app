import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.image}) : super(key: key);

  final image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45.0,
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 45.0,
      ),
    );
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(30.0),
    //   child: Container(
    //       width: width,
    //       height: height,
    //       child: Image.asset('assets/images/test.jpg', fit: BoxFit.cover)),
    // );
  }
}
