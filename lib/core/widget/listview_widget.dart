import 'package:contacts_app/core/utils/contact_utils.dart';
import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';
import 'package:contacts_app/feature/contact_list/presentation/page/contact_form_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key, required this.contactList}) : super(key: key);

  final List<Contact> contactList;

  @override
  Widget build(BuildContext context) {
    ContactUtils.sortContacts(contactList);
    return ListView.separated(
      itemCount: contactList.length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = contactList[index];
        int? contactId = contact.id;
        String? contactPhoto = contact.photo;
        return InkWell(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                contactPhoto != null
                    ? ClipOval(
                        child: Image.file(
                          File(contactPhoto),
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const CircleAvatar(
                        foregroundImage:
                            AssetImage('assets/images/account_circle.png'),
                        backgroundColor: Colors.white,
                        radius: 22.0,
                      ),
                const SizedBox(width: 16.0),
                Expanded(child: Text(contact.name ?? '')),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactFormPage(
                  contact: contact,
                  contactIndex: index,
                  contactId: contactId,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 0,
      ),
    );
  }
}
