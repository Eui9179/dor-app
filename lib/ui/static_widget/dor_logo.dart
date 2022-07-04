import 'package:flutter/material.dart';

class DorLogo extends StatelessWidget {
  const DorLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Image.asset(
        'assets/images/logo/dor.jpg',
        fit: BoxFit.cover,
        width: 40,
        height: 40,
      ),
    );
  }
}
