import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/models/loan_model.dart';
import 'package:pacs_loan_calc/models/loan_type.dart';

class LoanTypesViewModel extends ChangeNotifier {
  List<LoanTypeModel> _loanTypes = [];

  List<LoanTypeModel> get loanTypes => _loanTypes;

  Future<void> loadLoanTypes() async {
    _loanTypes = await LoanTypeStorage.loadLoanTypes();
    notifyListeners();
  }

  Future<void> addLoanType(LoanTypeModel loan) async {
    _loanTypes.add(loan);
    await LoanTypeStorage.saveLoanTypes(_loanTypes);
    notifyListeners();
  }

  Future<LoanTypeModel?> getLoanTypeByName(String name) async {
    final loanType = await LoanTypeStorage.getLoanTypeByName(name);
    return loanType;
  }

  Future<void> updateLoanType(int index, LoanTypeModel loan) async {
    _loanTypes[index] = loan;
    await LoanTypeStorage.saveLoanTypes(_loanTypes);
    notifyListeners();
  }

  Future<void> deleteLoanType(int index) async {
    _loanTypes.removeAt(index);
    await LoanTypeStorage.saveLoanTypes(_loanTypes);
    notifyListeners();
  }
}
