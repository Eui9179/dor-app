import 'package:dor_app/ui/static_widget/woojoo_logo.dart';
import 'package:flutter/material.dart';
import '../../utils/color_palette.dart';
import 'dor_logo.dart';

class WoojooLogoAndName extends StatelessWidget {
  const WoojooLogoAndName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          WoojooLogo(),
          SizedBox(
            width: 8,
          ),
          Text('우주',
              style: TextStyle(
                color: ColorPalette.font,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
    );
  }
}
