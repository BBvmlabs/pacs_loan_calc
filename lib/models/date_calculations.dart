import 'package:pacs_loan_calc/models/month_calculation.dart';

class DateCalculations {
  final DateTime sancationDate;
  final DateTime startDate;
  final DateTime givenEndDate;
  final int months;

  DateCalculations({
    required this.sancationDate,
    required this.startDate,
    required this.givenEndDate,
    required this.months,
  });

  int _monthDifference(DateTime startDate, DateTime endDate) =>
      (endDate.year - startDate.year) * 12 + (endDate.month - startDate.month);

  DateTime _loanEndDate() {
    MonthsCalculationInput obj = MonthsCalculationInput(
        months: months, startDate: startDate, givenEndDate: givenEndDate);

    return obj.addMonths();
  }

  Map<String, int> _dateCalculation(
      DateTime startDate, DateTime endDate, int months) {
    DateTime loanEndDate = _loanEndDate();

    final result = <String, int>{
      'loanActiveDays': 0,
      'reminingDays': 0,
      'odiDays': 0,
    };

    if (endDate.isAfter(loanEndDate)) {
      result['loanActiveDays'] = loanEndDate.difference(startDate).inDays;
      result['reminingDays'] = 0;
      result['odiDays'] = endDate.difference(loanEndDate).inDays;
    } else if (endDate.isAfter(startDate)) {
      result['loanActiveDays'] = endDate.difference(startDate).inDays;
      result['reminingDays'] = loanEndDate.difference(endDate).inDays;
      result['odiDays'] = 0;
    } else {
      result['loanActiveDays'] = 0;
      result['reminingDays'] = loanEndDate.difference(startDate).inDays;
      result['odiDays'] = 0;
    }

    return result;
  }

  int monthDifference() => _monthDifference(sancationDate, givenEndDate);

  Map<String, dynamic> dateCalculation() {
    final loanEndDate = _loanEndDate();
    final monthDiff = monthDifference();

    // Default calculation between start and given end date
    Map<String, int> dateMap =
        _dateCalculation(startDate, givenEndDate, months);

    // If loan end date is before or equal to today, override calculation
    if (loanEndDate.isBefore(givenEndDate) ||
        loanEndDate.isAtSameMomentAs(givenEndDate)) {
      dateMap = _dateCalculation(startDate, givenEndDate, months);
    }

    return {
      "daysMap": dateMap,
      "loanTime": months,
      "monthsActive": monthDiff,
      "sancationDate": sancationDate,
      "intrestStartDate": startDate,
      "loanEndDate": loanEndDate,
      "givenEndDate": givenEndDate
    };
  }
}
