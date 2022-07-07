import 'package:dor_app/main.dart';
import 'package:dor_app/ui/static_widget/dor_logo.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainBar extends StatelessWidget implements PreferredSizeWidget {
  const MainBar({Key? key}) : super(key: key);
  static final storage = FlutterSecureStorage();

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
          icon: Icon(Icons.person_add),
          splashRadius: 25,
          tooltip: '내 주변',
          onPressed: () => {},
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
          ),
          splashRadius: 25,
          tooltip: '설정',
          onPressed: () {
            storage.delete(key: "isLogin");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
              (route) => false,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const Login()),
            // )
          },
        ),
        const SizedBox(
          width: 7,
        )
      ],
    );
  }
}
