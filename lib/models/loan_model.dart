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

  Map<String, dynamic> toJson() => {
        'name': name,
        'months': months,
        'normalPercentage': normalPercentage,
        'odPercentage': odPercentage,
      };

  factory LoanTypeModel.fromJson(Map<String, dynamic> json) => LoanTypeModel(
        name: json['name'],
        months: json['months'],
        normalPercentage: json['normalPercentage'],
        odPercentage: json['odPercentage'],
      );
}
