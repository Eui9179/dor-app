import 'package:flutter/material.dart';

class SubjectTitle extends StatelessWidget {
  const SubjectTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            color: Color.fromARGB(255, 172, 172, 172), fontSize: 15));
  }
}
