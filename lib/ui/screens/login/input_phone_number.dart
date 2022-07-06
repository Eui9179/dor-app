import 'package:dor_app/ui/static_widget/dor_logo.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../dynamic_widget/font/font.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({Key? key}) : super(key: key);

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.mainBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: DorLogo(),
      ),
      body:Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Font(text:"내 전화번호", size:35),
                SizedBox(
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    style: const TextStyle(fontSize: 30.0, height: 2.0, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                      prefixText: "010 ",
                    ),
                  ),
                ),
              ],
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  fixedSize: Size(350, 50),
                  primary: Colors.black,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InputPhoneNumber()),
                );
              },
              child: const Text(
                "계속",
                style: TextStyle(fontSize: 23),
              ),
            )
          ],
        )
      )
    );
  }
}
