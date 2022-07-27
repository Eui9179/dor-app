List<String> getDorGameList() {
  return [
    "leagueoflegends",
    "battleground",
    "lostark",
    // "suddenattack",
    "fallguys",
    "minecraft",
    "valorant",
    "roblox",
    "overwatch",
    "maplestory",
    "fifaonline4",
    "tft",
    "starcraft",
    "starcraft2",
    // "hearthstone",
    // "dungeonandfighter",
    // "counterstrike",
    // "apexlegends",
    // "fortnite",
    // "gta5",
    // "dota2",
    // "callofduty",
    // "worldofwarcraft",
    // "diablo2",
  ];
}

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
    case "battleground":
      return "배틀그라운드";
    case "lostark":
      return "로스트아크";
    case "minecraft":
      return "마인크래프트";
    case "fifaonline4":
      return "피파 온라인4";
    case "starcraft":
      return "스타크래프트";
    case "starcraft2":
      return "스타크래프트2";
    case "counterstrike":
      return "카운터스트라이크";
    case "apexlegends":
      return "에픽 레전드";
    case "fortnite":
      return "포트나이트";
    case "gta5":
      return "gta 5";
    case "dota2":
      return "도타 2";
    case "fallguys":
      return "폴가이즈";
    case "callofduty":
      return "콜오브듀티";
    case "worldofwarcraft":
      return "월드오브워크래프트";
    case "hearthstone":
      return "하스스톤";
    case "maplestory":
      return "메이플스토리";
    case "suddenattack":
      return "서든어택";
    case "dungeonandfighter":
      return "던전앤파이터";
    case "diablo2":
      return "디아블로2";
    case "roblox":
      return "로블록스";
    default:
      return "게임";
  }
}
