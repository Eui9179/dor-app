import 'package:flutter/material.dart';

class WoojooLogo extends StatelessWidget {
  const WoojooLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Image.asset(
        'assets/images/logo/logo.png',
        fit: BoxFit.cover,
        width: 30,
        height: 30,
      ),
    );
  }
}
