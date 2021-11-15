import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';

abstract class ContactEvent {}

class CreateContact extends ContactEvent {
  Contact? newContact;

  CreateContact(Contact contact) {
    newContact = contact;
  }
}

class UpdateContact extends ContactEvent {
  Contact? newContact;
  int? contactIndex;

  UpdateContact(int index, Contact contact) {
    newContact = contact;
    contactIndex = index;
  }
}

class DeleteContact extends ContactEvent {
  int? contactIndex;

  DeleteContact(int index) {
    contactIndex = index;
  }
}

class SetContacts extends ContactEvent {
  List<Contact>? contactList;

  SetContacts(List<Contact> contacts) {
    contactList = contacts;
  }
}

class SetFavoriteContacts extends ContactEvent {
  List<Contact>? favoriteContacts;

  SetFavoriteContacts(List<Contact> contacts) {
    favoriteContacts = contacts;
  }
}
