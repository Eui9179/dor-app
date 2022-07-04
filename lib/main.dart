import 'package:dor_app/ui/screens/main/main.dart';
import 'package:dor_app/ui/screens/main/main_bar.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorPalette.headerBackgroundColor,
    ));
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DorApp extends StatefulWidget {
  const DorApp({Key? key}) : super(key: key);

  @override
  State<DorApp> createState() => _DorAppState();
}

class _DorAppState extends State<DorApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.mainBackgroundColor,
      appBar: MainBar(),
      body: SingleChildScrollView(
        child: Main(),
      ),
    );
  }
}
