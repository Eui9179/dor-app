class DorGroups {
  static final List<String> states = [
    "상일초등학교",
    "상일중학교",
    "상원고등학교",
    "상원초등학교",
    "석천초등학교",
    "석천중학교",
    "부천정보산업고등학교",
    "상동초등학교",
  ];


  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}


String changeGroupNameToFile(group) {
  switch (group) {
    case "상일초등학교":
      return "e_sangil";
    case "상일중학교":
      return "m_sangil";
    case "상원고등학교":
      return "h_sangwon";
    case "상원초등학교":
      return "e_sangwon";
    case "석천초등학교":
      return "e_sukchen";
    case "석천중학교":
      return "m_seokcheon";
    case "부천정보산업고등학교":
      return "h_industry";
    case "상동초등학교":
      return "e_sangdong";
    default:
      return "school";
  }
}
