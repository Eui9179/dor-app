import 'package:flutter/material.dart';

notification(context, String text, {warning = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Container(
          padding: const EdgeInsets.only(top: 5),
          height: 35,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: warning
            ? const Color.fromARGB(255, 246, 122, 122)
            : Colors.blueAccent),
  );
}
