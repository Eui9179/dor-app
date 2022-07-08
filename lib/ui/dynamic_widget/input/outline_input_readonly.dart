import 'package:flutter/material.dart';

class OutlineInputReadOnly extends StatelessWidget {
  const OutlineInputReadOnly({Key? key, required this.hintText})
      : super(key: key);
  final hintText;

  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide:
            const BorderSide(color: Color.fromARGB(255, 52, 52, 71), width: 2));
    final focusedBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2));

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: TextFormField(
        readOnly: true,
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
        decoration: InputDecoration(
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 206, 206, 215)),
          labelText: "전화번호",
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: const Color.fromARGB(255, 62, 62, 75),
          filled: true,
        ),
      ),
    );
  }
}
