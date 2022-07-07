import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.btnEnabled,
      required this.onPressed,
      required this.text})
      : super(key: key);

  final bool btnEnabled;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (btnEnabled) ? onPressed : null,
      style: OutlinedButton.styleFrom(
          fixedSize: const Size(400, 50),
          primary: Colors.black,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
      child: Text(
        text,
        style: const TextStyle(fontSize: 23),
      ),
    );
  }
}
