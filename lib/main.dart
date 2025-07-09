import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/routes/app_routes.dart';
import 'package:pacs_loan_calc/view/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PACS Loan Calculator',
      home: const HomeScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
