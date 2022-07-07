import 'package:flutter/material.dart';

notification(context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: EdgeInsets.only(top:5),
        height: 30,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Color.fromARGB(255, 246, 122, 122),
    ),
  );
}
