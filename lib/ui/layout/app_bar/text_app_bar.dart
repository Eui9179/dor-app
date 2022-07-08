import 'package:flutter/material.dart';
import '../../../utils/color_palette.dart';

class TextAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TextAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: ColorPalette.mainBackgroundColor,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: ColorPalette.font),
      ),
      centerTitle: true,
    );
  }
}
