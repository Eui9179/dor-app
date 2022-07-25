import 'package:dor_app/controller/access_token_controller.dart';
import 'package:dor_app/controller/my_games_controller.dart';
import 'package:dor_app/controller/my_groups_controller.dart';
import 'package:dor_app/controller/my_profile_controller.dart';
import 'package:dor_app/pages.dart';
import 'package:dor_app/ui/layout/app_bar/text_app_bar.dart';
import 'package:dor_app/ui/screens/authentication/login_screen.dart';
import 'package:dor_app/ui/screens/home/main_page.dart';
import 'package:dor_app/utils/color_palette.dart';
import 'package:dor_app/utils/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'controller/my_friends_controller.dart';
import 'dio/friend/get_my_friends.dart';
import 'dio/game/get_my_games.dart';
import 'dio/group/get_my_groups.dart';
import 'dio/profile/get_my_profile.dart';
import 'firebase_options.dart';

const storage = FlutterSecureStorage();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ColorPalette.headerBackgroundColor,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.put(AccessTokenController());
    Get.put(MyFriendsController());
    Get.put(MyProfileController());
    Get.put(MyGroupsController());
    Get.put(MyGamesController());

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

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _accessToken;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<String?> res = _getAccessToken();
      res.then((value){
        if (value != null){
          print('accesstoken: $value');
          Future<void> res = _initUserData();
          res.then((val){
            // FlutterNativeSplash.remove();
          });
        } else {
          // FlutterNativeSplash.remove();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_accessToken == null){
      return const LoginPage();
    } else {
      return const MainPage();
    }
  }
  Future<String?> _getAccessToken() async {
    String? accessToken = await storage.read(key: "accessToken");
    if (accessToken != null) {
      Get.find<AccessTokenController>().setAccessToken(accessToken);
    }
    setState(() {
      _accessToken = accessToken;
    });
    return accessToken;
  }

  Future<void> _initUserData() async {
    _initMyProfile();
    _initMyGroups();
    _initMyGameList();
    _initMyFriendList();
    return;
  }

  _initMyProfile() {
    Future<Map<String, dynamic>> response = dioApiGetMyProfile(_accessToken);
    response.then((res) {
      print(res);
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Map<String, dynamic> profileData = res["data"];
        Get.find<MyProfileController>().setMyProfile(profileData["name"],
            profileData["profile_image_name"], profileData["phone_number"]);
      } else if (statusCode == 401) {
      } else {
        print("_getMyProfile() error: $statusCode");
      }
    });
  }

  void _initMyGroups() {
    Future<Map<String, dynamic>> response = dioApiGetMyGroups(_accessToken);
    response.then((res) {
      int statusCode = res['statusCode'];
      if (statusCode == 200) {
        Get.find<MyGroupsController>().setMyGroups(res['data']);
      } else if (statusCode == 401) {}
    });
  }

  void _initMyGameList() {
    Future<dynamic> response = dioApiGetMyGames(_accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Get.find<MyGamesController>().setMyGames(res['data']);
      } else if (statusCode == 401) {}
    });
  }

  void _initMyFriendList() {
    Future<dynamic> response = dioApiGetMyFriends(_accessToken);
    response.then((res) {
      int statusCode = res["statusCode"];
      if (statusCode == 200) {
        Get.find<MyFriendsController>().setMyFriends(res['data']);
      } else if (statusCode == 401) {
      } else {
        print('_getMyFriendList() error: $statusCode');
      }
    });
  }

}