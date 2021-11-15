import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_event.dart';
import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';

class ContactBloc extends Bloc<ContactEvent, List<Contact>> {
  ContactBloc(List<Contact> initialState) : super(initialState);

  @override
  Stream<List<Contact>> mapEventToState(ContactEvent event) async* {
    if (event is SetContacts) {
      yield event.contactList!;
    } else if (event is CreateContact) {
      List<Contact> newState = List.from(state);
      if (event.newContact != null) {
        newState.add(event.newContact!);
      }
      yield newState;
    } else if (event is DeleteContact) {
      List<Contact> newState = List.from(state);
      newState.removeAt(event.contactIndex!);
      yield newState;
    } else if (event is UpdateContact) {
      List<Contact> newState = List.from(state);
      newState[event.contactIndex!] = event.newContact!;
      yield newState;
    } else if (event is SetFavoriteContacts) {
      yield event.favoriteContacts!;
    }
  }
}
