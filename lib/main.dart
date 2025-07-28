import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/view_model/calculator_result_view_model.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:pacs_loan_calc/models/loan_type.dart';
import 'package:pacs_loan_calc/routes/app_routes.dart';
import 'package:pacs_loan_calc/view/home/home_screen.dart';
import 'package:pacs_loan_calc/view_model/loan_types_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loanTypes = await LoanTypeStorage.initIfEmpty();

  for (final loan in loanTypes) {
    print('${loan.name} - ${loan.months} months @ ${loan.normalPercentage}%');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LoanTypesViewModel()..loadLoanTypes()),
        ChangeNotifierProvider(
            create: (_) => CalculatorResultViewModel(
                  loanName: '',
                  loanAmount: 0,
                  interestRate: 0,
                  odInterestRate: 0,
                  sanctionDate: DateTime.now(),
                  interestStartDate: DateTime.now(),
                  givenEndDate: DateTime.now(),
                  months: 0,
                )),
      ],
      child: const MainApp(),
    ),
  );
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
