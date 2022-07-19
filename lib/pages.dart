import 'package:dor_app/ui/screens/authentication/input_phone_number.dart';
import 'package:dor_app/ui/screens/authentication/login_screen.dart';
import 'package:dor_app/ui/screens/authentication/signup/step1_profile.dart';
import 'package:dor_app/ui/screens/authentication/signup/step2_tos.dart';
import 'package:dor_app/ui/screens/authentication/verification.dart';
import 'package:dor_app/ui/screens/group/group_detail.dart';
import 'package:dor_app/ui/screens/friends/acquaintance.dart';
import 'package:dor_app/ui/screens/setting/games.dart';
import 'package:dor_app/ui/screens/users/users.dart';
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
      name: '/setting/games',
      page: () => const GamesSetting(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/group/detail',
      page: () => const GroupDetail(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/acquaintance',
      page: () => Acquaintance(),
      transition: Transition.rightToLeft),
  GetPage(
      name: '/users/:userId',
      page: () => const Users(),
      transition: Transition.rightToLeft),
];
