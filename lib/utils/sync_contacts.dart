import 'package:contacts_service/contacts_service.dart';

List<String?> formattedContacts(List<String?> contacts) {
  List<String> result = [];
  for (var contact in contacts) {
    if (contact != null){
      if(contact.contains("010")){
        String formatted = contact.replaceAll('-', '');
        result.add("+82$formatted");
      }
    }
  }
  print(result);
  return result;
}
