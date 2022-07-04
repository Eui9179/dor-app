import 'package:flutter/material.dart';

class DorAvatar extends StatelessWidget {
  const DorAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset('assets/images/logo/dor.jpg', fit: BoxFit.cover)),
    );
  }
}
