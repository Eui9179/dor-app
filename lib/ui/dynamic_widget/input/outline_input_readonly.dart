import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class OutlineInputReadOnly extends StatelessWidget {
  const OutlineInputReadOnly({Key? key, required this.hintText, required this.labelText, required this.onTap})
      : super(key: key);
  final String? hintText;
  final String labelText;
  final VoidCallback onTap;

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
        style: const TextStyle(fontSize: 20.0, color: ColorPalette.font),
        onTap: onTap,
        decoration: InputDecoration(
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 206, 206, 215)),
          labelText: labelText,
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
