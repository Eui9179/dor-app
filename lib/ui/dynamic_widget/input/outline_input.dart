import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';

class OutlineInput extends StatefulWidget {
  final void Function(String?) onSaved;
  final void Function(String?) onChanged;
  final String? Function(String?) validator;
  final String labelText;
  final bool autoFocus;

  const OutlineInput({
    Key? key,
    required this.onSaved,
    required this.onChanged,
    required this.validator,
    required this.labelText,
    required this.autoFocus,
  }) : super(key: key);

  @override
  State<OutlineInput> createState() => _OutlineInputState();
}

class _OutlineInputState extends State<OutlineInput> {
  final enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 52, 52, 71), width: 2));
  final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          TextFormField(
            autofocus: widget.autoFocus,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.always,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
            validator: widget.validator,
            style: const TextStyle(fontSize: 20.0, color: ColorPalette.font),
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 62, 62, 75),
              filled: true,
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                  color: Color.fromARGB(255, 206, 206, 215), fontSize: 20),
              enabledBorder: enabledBorder,
              focusedBorder: focusedBorder,
            ),
          ),
        ],
      ),
    );
  }
}
