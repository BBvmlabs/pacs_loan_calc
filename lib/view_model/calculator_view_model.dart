import 'package:flutter/foundation.dart';
import 'package:pacs_loan_calc/models/loan_model.dart';
import 'package:pacs_loan_calc/models/loan_type.dart';

class CalculatorViewModel extends ChangeNotifier {
  List<LoanTypeModel> _loanTypes = [];

  List<LoanTypeModel> get loanTypes => _loanTypes;

  Future<void> loadLoanTypes() async {
    _loanTypes = await LoanTypeStorage.loadLoanTypes();
    notifyListeners();
  }

  Future<void> selectedLoanType(LoanTypeModel loan) async {
    _loanTypes.add(loan);
    await LoanTypeStorage.saveLoanTypes(_loanTypes);
    notifyListeners();
  }
}
