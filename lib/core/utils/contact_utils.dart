import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';

class ContactUtils {
  static sortContacts(List<Contact> contactList) {
    if (contactList != null) {
      contactList.sort((a, b) {
        return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
      });
    }
  }
}
