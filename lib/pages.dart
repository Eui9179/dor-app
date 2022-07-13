import 'package:dor_app/ui/screens/authentication/input_phone_number.dart';
import 'package:dor_app/ui/screens/authentication/login_screen.dart';
import 'package:dor_app/ui/screens/authentication/signup/step1_profile.dart';
import 'package:dor_app/ui/screens/authentication/signup/step2_tos.dart';
import 'package:dor_app/ui/screens/authentication/verification.dart';
import 'package:dor_app/ui/screens/setting/my_games.dart';
import 'package:get/get.dart';
import 'main.dart';

List<GetPage> pages = [
  GetPage(name: '/', page: () => const Home()),
  GetPage(
      name: '/login',
      page: () => const LoginPage(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/auth',
      page: () => const InputPhoneNumber(),
      transition: Transition.rightToLeft),
  GetPage(
    name: '/auth/verification',
    page: () => const Verification(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
      name: '/auth/signup/step1',
      page: () => const Step1Profile(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/auth/signup/step2',
      page: () => const Step2TOS(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/setting/my-games',
      page: () => const MyGamesSetting(),
      transition: Transition.rightToLeft),
];
