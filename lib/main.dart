import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';
import 'package:contacts_app/feature/contact_list/presentation/page/contact_list_page.dart';
import 'package:flutter/material.dart';
import 'feature/contact_list/presentation/bloc/contact_bloc.dart';
import 'feature/contact_list/presentation/page/contact_form_page.dart';
import 'feature/contact_list/presentation/page/favorite_contact_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

List<Contact> initialState = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(initialState),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: Colors.teal, secondary: Colors.teal),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
            elevation: 0.5,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const ContactListPage(),
          '/favorite-contacts': (context) => const FavoriteContactListPage(),
          '/contact-form': (context) => const ContactFormPage(),
        },
      ),
    );
  }
}
