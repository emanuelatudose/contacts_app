import 'package:contacts_app/core/widget/listview_widget.dart';
import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_bloc.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_event.dart';
import 'package:contacts_app/feature/navigation/presentation/widget/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/feature/contact_list/data/repository/contact_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  void initState() {
    super.initState();
    ContactRepositoryImpl.instance.getContacts().then(
      (contactList) {
        BlocProvider.of<ContactBloc>(context).add(SetContacts(contactList));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact List')),
      drawer: const NavigationWidget(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocConsumer<ContactBloc, List<Contact>>(
              builder: (context, contactList) {
                return contactList.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                                'The contact list is empty, please add contacts.'),
                          ),
                        ],
                      )
                    : ListViewWidget(contactList: contactList);
              },
              listener: (BuildContext context, contactList) {},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/contact-form');
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
