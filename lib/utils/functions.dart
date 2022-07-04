import 'package:flutter/material.dart';

String changeKorGameName(gameName) {
  switch (gameName) {
    case "leagueoflegends":
      return "리그 오브 레전드";
    case "overwatch":
      return "오버워치";
    case "valorant":
      return "발로란트";
    case "tft":
      return "전략적 팀 전투";
    default:
      return "게임";
  }
}
