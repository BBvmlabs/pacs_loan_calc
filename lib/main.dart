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
            title: const Row(
          children: [
            SizedBox(width: 10),
            Image(
              image: AssetImage("src/assets/images/logo.png"),
              width: 50,
              height: 50,
            ),
            SizedBox(width: 10),
            Text('PACS Loan Calculator'),
            SizedBox(width: 15),
            IconButton(onPressed: null, icon: Icon(Icons.more_vert))
          ],
        )),
        body: const CalculatorScreen(),
      ),
    );
  }
}
