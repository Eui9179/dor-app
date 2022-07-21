import 'package:dor_app/ui/static_widget/dor_logo.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageBar extends StatelessWidget implements PreferredSizeWidget {
  const MainPageBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.headerBackgroundColor,
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            DorLogo(),
            SizedBox(
              width: 8,
            ),
            Text('DOR',
                style: TextStyle(
                  color: ColorPalette.font,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.settings,
          ),
          splashRadius: 25,
          tooltip: '설정',
          onPressed: () {
            Get.toNamed('/setting');
          },
        ),
        const SizedBox(
          width: 7,
        )
      ],
    );
  }
}