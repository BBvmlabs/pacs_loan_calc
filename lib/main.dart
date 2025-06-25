import 'package:flutter/material.dart';
import 'view/calculator/calculator_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'src/assets/images/logo.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: 40,
              height: 40,
            ),
          ),
          title: const Text(
            'PACS Loan Calculator',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (value) {
                // Handle menu selection here
                // Example: print(value);
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem(
                  value: 'Value',
                  child: Text('Value'),
                ),
                const PopupMenuItem(
                  value: 'About',
                  child: Text('About'),
                ),
              ],
            ),
          ],
        ),
        body: const CalculatorScreen(),
      ),
    );
  }
}
