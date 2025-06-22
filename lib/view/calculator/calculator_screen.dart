import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController termController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoanCalculatorRow(
          label: "Loan Amount",
          controller: amountController,
        ),
        LoanCalculatorRow(
          label: "Interest Rate",
          controller: interestController,
        ),
        LoanCalculatorRow(
          label: "Loan Term",
          controller: termController,
        )
      ],
    );
  }
}
