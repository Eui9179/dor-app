import 'package:flutter/material.dart';

class SubjectTitle extends StatelessWidget {
  const SubjectTitle({Key? key, required this.title}) : super(key: key);

  final title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(title,
            style: const TextStyle(
                color: Color.fromARGB(255, 172, 172, 172), fontSize: 15)));
  }
}
