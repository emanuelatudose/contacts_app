import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Text(
              'Contacts App',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
          ListTile(
            title: const Text('Contact list screen'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Favorite contacts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorite-contacts');
            },
          ),
          ListTile(
            title: const Text('Add new contact'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact-form');
            },
          ),
        ],
      ),
    );
  }
}
