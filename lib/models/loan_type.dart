import 'dart:convert';
import 'package:pacs_loan_calc/models/loan_model.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class LoanTypeStorage {
  static const _storageKey = 'loan_types';

  /// Save list of LoanTypeModel to SharedPreferences
  static Future<void> saveLoanTypes(List<LoanTypeModel> loans) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(loans.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  /// Load list of LoanTypeModel from SharedPreferences
  static Future<List<LoanTypeModel>> loadLoanTypes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => LoanTypeModel.fromJson(e)).toList();
  }

  static Future<LoanTypeModel?> getLoanTypeByName(String name) async {
    final loanTypes = getDefaultLoanTypes();

    try {
      return loanTypes.firstWhere((e) => e.name == name);
    } catch (_) {
      // fallback to default list
      try {
        return getDefaultLoanTypes().firstWhere((e) => e.name == name);
      } catch (_) {
        return null; // not found in either
      }
    }
  }

  /// Initialize with default 3 loan types if none exist
  static Future<List<LoanTypeModel>> initIfEmpty() async {
    final existing = await loadLoanTypes();
    if (existing.isNotEmpty) return existing;

    final defaultLoans = getDefaultLoanTypes();

    await saveLoanTypes(defaultLoans);
    return defaultLoans;
  }

  static List<LoanTypeModel> getDefaultLoanTypes() => [
        LoanTypeModel(
            name: 'Gold Loan',
            months: 12,
            normalPercentage: 6.5,
            odPercentage: 9.0),
        LoanTypeModel(
            name: 'Paddy Loan',
            months: 8,
            normalPercentage: 7.5,
            odPercentage: 10.0),
        LoanTypeModel(
            name: 'Sugar Cane Loan',
            months: 15,
            normalPercentage: 5.0,
            odPercentage: 8.5),
      ];
}
