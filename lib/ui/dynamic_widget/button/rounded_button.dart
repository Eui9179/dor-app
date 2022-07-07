import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          fixedSize: Size(350, 50),
          primary: Colors.black,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ),
        // );
      },
      child: const Text(
        "계속",
        style: TextStyle(fontSize: 23),
      ),
    );
  }
}
