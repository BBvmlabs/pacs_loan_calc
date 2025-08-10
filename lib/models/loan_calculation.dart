import 'package:pacs_loan_calc/models/date_calculations.dart';

class LoanCalculationInput {
  final String loanName;
  final double loanAmount;
  final double interestRate;
  final double odInterestRate;
  final int months;
  final DateTime sanctionDate;
  final DateTime interestStartDate;
  final DateTime givenEndDate;

  /// Dynamic current date (not final)
  DateTime get today => DateTime.now();

  LoanCalculationInput({
    required this.loanName,
    required this.loanAmount,
    required this.interestRate,
    required this.odInterestRate,
    required this.months,
    required this.sanctionDate,
    required this.interestStartDate,
    required this.givenEndDate,
  });

  Map<String, dynamic> _interestCalculation(
      double principal, double interestRate, int days) {
    double calcPerDay =
        _roundToTwoDecimals(principal * (interestRate / 100) * (1 / 365));
    double calcTotalDays =
        _roundToTwoDecimals(principal * (interestRate / 100) * (days / 365));

    return {
      "days": days,
      "calcPerDay": calcPerDay,
      "calcTotalDays": calcTotalDays,
    };
  }

  /// Private rounding method to 2 decimal places
  double _roundToTwoDecimals(double value) =>
      (value * 100).roundToDouble() / 100;

  Map<String, dynamic> gettingDateDict() {
    DateCalculations obj = DateCalculations(
        sancationDate: sanctionDate,
        startDate: interestStartDate,
        givenEndDate: givenEndDate,
        months: months);
    return obj.dateCalculation();
  }

  Map<String, dynamic> _loanCanculation(
      double principal, double intrest, double odIntrest, daysDict) {
    Map<String, dynamic> totalPrinciple = _interestCalculation(
        principal, interestRate, daysDict["daysMap"]["loanActiveDays"]);
    Map<String, dynamic> intrestPrinciple = {
      "days": 0,
      "calcPerDay": 0,
      "calcTotalDays": 0
    };
    Map<String, dynamic> odIntrestPrinciple = {
      "days": 0,
      "calcPerDay": 0,
      "calcTotalDays": 0
    };

    Map<String, dynamic> totalNormalPrinciple = {
      "days": 0,
      "calcPerDay": 0,
      "calcTotalDays": 0
    };

    Map<String, dynamic> totalIntrestPrinciple = {
      "days": 0,
      "calcPerDay": 0,
      "calcTotalDays": 0
    };

    if (daysDict["daysMap"]["reminingDays"] != 0) {
      intrestPrinciple = _interestCalculation(
          principal, odInterestRate, daysDict["daysMap"]["reminingDays"]);
    }

    if (daysDict["daysMap"]["odiDays"] != 0) {
      odIntrestPrinciple = _interestCalculation(
          principal, odInterestRate, daysDict["daysMap"]["odiDays"]);
    }

    if (daysDict["daysMap"]["loanActiveDays"] != 0 &&
        daysDict["daysMap"]["reminingDays"] != 0 &&
        daysDict["daysMap"]["odiDays"] == 0) {
      totalNormalPrinciple = _interestCalculation(
          principal,
          interestRate,
          daysDict["daysMap"]["loanActiveDays"] +
              daysDict["daysMap"]["odiDays"]);

      totalIntrestPrinciple["days"] =
          totalPrinciple["days"] + odIntrestPrinciple["days"];
      totalIntrestPrinciple["calcPerDay"] =
          totalPrinciple["calcPerDay"] + odIntrestPrinciple["calcPerDay"];
      totalIntrestPrinciple["calcTotalDays"] = loanAmount +
          totalNormalPrinciple["calcTotalDays"] +
          odIntrestPrinciple["calcTotalDays"];
    }

    if (daysDict["daysMap"]["loanActiveDays"] != 0 &&
        daysDict["daysMap"]["reminingDays"] == 0 &&
        daysDict["daysMap"]["odiDays"] != 0) {
      totalNormalPrinciple = _interestCalculation(
          principal,
          interestRate,
          daysDict["daysMap"]["loanActiveDays"] +
              daysDict["daysMap"]["odiDays"]);

      totalIntrestPrinciple["days"] =
          totalPrinciple["days"] + odIntrestPrinciple["days"];
      totalIntrestPrinciple["calcPerDay"] =
          totalPrinciple["calcPerDay"] + odIntrestPrinciple["calcPerDay"];
      totalIntrestPrinciple["calcTotalDays"] = loanAmount +
          totalNormalPrinciple["calcTotalDays"] +
          odIntrestPrinciple["calcTotalDays"];
    }

    return {
      "loanName": loanName,
      "loanAmount": loanAmount,
      "interestRate": interestRate,
      "odInterestRate": odInterestRate,
      "months": months,
      "sanctionDate": sanctionDate,
      "interestStartDate": interestStartDate,
      "givenEndDate": givenEndDate,
      "daysMap": daysDict["daysMap"],
      "normalIntrest": totalPrinciple,
      "reminingIntrest": intrestPrinciple,
      "odIntrest": odIntrestPrinciple,
      "actualEndDate": daysDict["loanEndDate"],
      "activeMonths": daysDict["monthsActive"],
      "totalNormalPrinciple": totalNormalPrinciple,
      "totalCalculation": totalIntrestPrinciple
    };
  }

  Map<String, dynamic> loanCalculation() => _loanCanculation(
      loanAmount, interestRate, odInterestRate, gettingDateDict());
}
