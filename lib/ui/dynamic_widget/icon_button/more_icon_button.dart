import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class MoreIconButton extends StatelessWidget {
  const MoreIconButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      tooltip: "더보기",
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.more_vert,
          color: ColorPalette.font, size: 20),
    );
  }
}
