import 'package:dor_app/ui/screens/authentication/login_screen.dart';
import 'package:dor_app/ui/screens/main/main.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'firebase_options.dart';

const storage = FlutterSecureStorage();

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
        primarySwatch: Colors.blueGrey,
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
  String? accessToken;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAccessToken();
    });
  }

  _getAccessToken() async {
    accessToken = await storage.read(key: "accessToken");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        body: Center(child: Text("Loading...")),
      );
    }

    if (accessToken == null) { // 로그인 안한 유저
      return const LoginPage();
    } else {
      return Main();
    }
  }
}
