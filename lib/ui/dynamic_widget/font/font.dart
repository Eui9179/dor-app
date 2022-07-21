import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class Font extends StatelessWidget {
  const Font({Key? key, required this.text, required this.size})
      : super(key: key);

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: ColorPalette.font),
    );
  }
}
