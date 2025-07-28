import 'package:flutter/foundation.dart';
import 'package:pacs_loan_calc/models/loan_calculation.dart';

class CalculatorResultViewModel with ChangeNotifier {
  // Input fields
  String loanName;
  double loanAmount;
  double interestRate;
  double odInterestRate;
  DateTime sanctionDate;
  DateTime interestStartDate;
  DateTime givenEndDate;
  int months;

  // Output fields
  Map<String, dynamic> result = {};

  CalculatorResultViewModel({
    required this.loanName,
    required this.loanAmount,
    required this.interestRate,
    required this.odInterestRate,
    required this.sanctionDate,
    required this.interestStartDate,
    required this.givenEndDate,
    required this.months,
  });

  Map<String, dynamic> calculate() {
    result = LoanCalculationInput(
      loanName: loanName,
      loanAmount: loanAmount,
      interestRate: interestRate,
      odInterestRate: odInterestRate,
      months: months,
      sanctionDate: sanctionDate,
      interestStartDate: interestStartDate,
      givenEndDate: givenEndDate,
    ).loanCalculation();

    notifyListeners(); // Notify UI to rebuild with result
    return result; // Notify UI to rebuild with result
  }
}
