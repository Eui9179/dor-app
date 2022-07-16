import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class DividingLine extends StatelessWidget {
  const DividingLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
        color: ColorPalette.dividingLine ,
        thickness: 1,
        endIndent: 3,
      );
  }
}
