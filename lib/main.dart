import 'package:dor_app/pages.dart';
import 'package:dor_app/ui/screens/authentication/input_phone_number.dart';
import 'package:dor_app/ui/screens/authentication/login_screen.dart';
import 'package:dor_app/ui/screens/authentication/signup/step1_profile.dart';
import 'package:dor_app/ui/screens/authentication/signup/step2_tos.dart';
import 'package:dor_app/ui/screens/setting/my_games.dart';
import 'package:dor_app/ui/screens/authentication/verification.dart';
import 'package:dor_app/ui/screens/home/main_page.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
      initialRoute: '/',
      getPages: pages,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  // TODO: 시작 페이지 보여주고 loading 처리

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? accessToken;
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAccessToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorPalette.headerBackgroundColor,
    ));

    if (isLoading) {
      return const Scaffold(
        backgroundColor: ColorPalette.mainBackgroundColor,
        body: Center(child: Text("Loading...")),
      );
    }

    if (accessToken == null) {
      // 로그인 안한 유저
      return const LoginPage();
    } else {
      return const MainPage();
    }
  }

  _getAccessToken() async {
    accessToken = await storage.read(key: "accessToken");
    setState(() {
      isLoading = false;
    });
  }
}
