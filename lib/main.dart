import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/models/loan_type.dart';
import 'package:pacs_loan_calc/routes/app_routes.dart';
import 'package:pacs_loan_calc/view/home/home_screen.dart';

// void main() {
//   runApp(const MainApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Important!

  final loanTypes = await LoanTypeStorage.initIfEmpty();

  for (final loan in loanTypes) {
    print('${loan.name} - ${loan.months} months @ ${loan.normalPercentage}%');
  }

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
