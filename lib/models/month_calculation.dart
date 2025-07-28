class MonthsCalculationInput {
  final int months;
  final DateTime startDate;
  final DateTime givenEndDate;

  MonthsCalculationInput(
      {required this.months,
      required this.startDate,
      required this.givenEndDate});

  /// Private method to add months safely
  DateTime _addMonths(DateTime date, int monthsToAdd) {
    int newYear = date.year + ((date.month + monthsToAdd - 1) ~/ 12);
    int newMonth = (date.month + monthsToAdd - 1) % 12 + 1;
    int newDay = date.day;

    // Adjust the day if it exceeds the last day of the new month
    int lastDay = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > lastDay) {
      newDay = lastDay;
    }

    return DateTime(newYear, newMonth, newDay);
  }

  /// Public method to call addMonths safely
  DateTime addMonths() => _addMonths(startDate, months);

  /// Optional: Calculate how many months between two dates
  int get monthsBetween {
    int years = givenEndDate.year - startDate.year;
    int monthsDiff = givenEndDate.month - startDate.month;
    return years * 12 + monthsDiff;
  }
}
