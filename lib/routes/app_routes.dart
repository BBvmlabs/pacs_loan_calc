import 'package:pacs_loan_calc/view/about/about_screen.dart';
import 'package:pacs_loan_calc/view/calculator/calculator_result.dart';
import 'package:pacs_loan_calc/view/calculator/calculator_screen.dart';
import 'package:pacs_loan_calc/view/file_saved/file_saved_screen.dart';
import 'package:pacs_loan_calc/view/loan_details/loan_details_screen.dart';
import 'package:pacs_loan_calc/view/settings/settings_screen.dart';
import 'package:pacs_loan_calc/view/values/edit_value_screen.dart';
import 'package:pacs_loan_calc/view/values/values_screen.dart';

final routes = {
  // '/': (context) => const HomeScreen(),
  '/calculator': (context) => const CalculatorScreen(),
  '/calculator-result': (context) => const CalculatorResult(),
  '/loan-details': (context) => const LoanDetails(),
  '/values': (context) => const ValuesScreen(),
  '/edit-value': (context) => const EditValueScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/about': (context) => const AboutScreen(),
  '/file-saved?true': (context) => const FileSavedScreen(isFileSaved: true),
  '/file-saved?false': (context) => const FileSavedScreen(isFileSaved: false),
};
