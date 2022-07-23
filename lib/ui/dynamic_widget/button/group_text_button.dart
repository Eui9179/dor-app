import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';

class GroupTextButton extends StatelessWidget {
  const GroupTextButton({Key? key, required this.text, required this.onTap}) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.school_sharp, color: ColorPalette.font, size: 19,),
              const SizedBox(width: 10,),
              Text(text, style: const TextStyle(color: ColorPalette.font, fontWeight: FontWeight.w400, fontSize: 20),),
            ],
          ),
          const Icon(Icons.chevron_right, color: ColorPalette.font,size: 18,),
        ],
      ),
    );
  }
}
