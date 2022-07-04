import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class SendIconButton extends StatelessWidget {
  const SendIconButton(
      {Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: "게임하자",
      splashRadius: 23,
      icon: const Icon(
        Icons.telegram,
        color: ColorPalette.sendButton,
        size: 35,
      ),
    );
  }
}
