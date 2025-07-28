import 'package:flutter/material.dart';

AppBar buildAppBar(String title, context, {bool isHome = false}) {
  return AppBar(
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 2,
    leading: Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
      child: isHome
          ? Image.asset(
              'src/assets/images/logo.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: 40,
              height: 40,
            )
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
    ),
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    centerTitle: false,
    actions: [
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: Colors.black),
        onSelected: (value) {
          // Handle menu selection here
          // Example: print(value);
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'Settings',
            child: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          PopupMenuItem(
            value: 'Value',
            child: const Text('Value'),
            onTap: () {
              Navigator.pushNamed(context, '/values');
            },
          ),
          PopupMenuItem(
            value: 'About',
            child: const Text('About'),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    ],
  );
}
