import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  final loan = const LoanCalculatorRow();

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [LoanCalculatorRow()],
    );
  }
}
