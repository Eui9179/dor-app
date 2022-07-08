import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';
import '../../static_widget/dor_logo.dart';

class LogoAppBar extends StatelessWidget implements PreferredSizeWidget  {
  const LogoAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.mainBackgroundColor,
      elevation: 0.0,
      centerTitle: true,
      title: const DorLogo(),
    );
  }
}
