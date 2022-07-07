import 'package:flutter/material.dart';
import '../../utils/color_palette.dart';
import 'dor_logo.dart';

class DorLogoAndName extends StatelessWidget {
  const DorLogoAndName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
