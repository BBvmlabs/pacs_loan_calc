class LoanTypeModel {
  final String name;
  final int months;
  final double normalPercentage;
  final double odPercentage;

  LoanTypeModel({
    required this.name,
    required this.months,
    required this.normalPercentage,
    required this.odPercentage,
  });
}
