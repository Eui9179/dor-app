import 'package:get/get.dart';

class MyGamesController extends GetxController {
  List<dynamic> games = [];

  void setMyGames(List<dynamic> games) {
    this.games = games;
    update();
  }

  void clear(){
    games = [];
    update();
  }
}
