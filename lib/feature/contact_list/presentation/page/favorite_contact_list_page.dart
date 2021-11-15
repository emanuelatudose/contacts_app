import 'package:contacts_app/core/widget/listview_widget.dart';
import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_bloc.dart';
import 'package:contacts_app/feature/contact_list/presentation/bloc/contact_event.dart';
import 'package:contacts_app/feature/navigation/presentation/widget/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/feature/contact_list/data/repository/contact_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteContactListPage extends StatefulWidget {
  const FavoriteContactListPage({Key? key}) : super(key: key);

  @override
  State<FavoriteContactListPage> createState() =>
      _FavoriteContactListPageState();
}

class _FavoriteContactListPageState extends State<FavoriteContactListPage> {
  @override
  void initState() {
    super.initState();
    ContactRepositoryImpl.instance.getFavoriteContacts().then(
      (favoriteList) {
        BlocProvider.of<ContactBloc>(context)
            .add(SetFavoriteContacts(favoriteList));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Contact List')),
      drawer: const NavigationWidget(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocConsumer<ContactBloc, List<Contact>>(
              builder: (context, favoriteList) {
                return favoriteList.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text('The favorite contacts list is empty.'),
                          ),
                        ],
                      )
                    : ListViewWidget(contactList: favoriteList);
              },
              listener: (BuildContext context, favoriteList) {},
            ),
          ),
        ],
      ),
    );
  }
}
