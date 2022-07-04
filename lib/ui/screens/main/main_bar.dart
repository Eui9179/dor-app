import 'package:dor_app/ui/static_widget/dor_logo.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class MainBar extends StatelessWidget implements PreferredSizeWidget {
  const MainBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.headerBackgroundColor,
      elevation: 0.0,
      title: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
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
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.location_on_rounded),
          splashRadius: 25,
          tooltip: '내 주변',
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
          ),
          splashRadius: 25,
          tooltip: '설정',
          onPressed: () => {},
        ),
        SizedBox(
          width: 7,
        )
      ],
    );
  }
}
