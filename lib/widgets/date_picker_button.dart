import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return DatePickerDialog(
        keyboardType: TextInputType.number,
        firstDate: DateTime(2025),
        lastDate: DateTime(2050),
        initialDate: DateTime.now());
  }
}

class DateTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');

    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 || i == 3) {
        buffer.write('/');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Date is required';
  }

  // Accepts flexible formats like D/M/YY or DD/MM/YYYY
  final regex = RegExp(r'^\d{1,2}/\d{1,2}/\d{2,4}$');
  if (!regex.hasMatch(value)) {
    return 'Enter a valid date format';
  }

  final parts = value.split('/');
  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  var year = int.tryParse(parts[2]);

  if (day == null || month == null || year == null) {
    return 'Invalid date parts';
  }

  // Convert 2-digit year to full year (assume 2000+ for simplicity)
  if (year < 100) {
    year += 2000;
  }

  try {
    final date = DateTime(year, month, day);
    if (date.day != day || date.month != month || date.year != year) {
      return 'Invalid date';
    }

    // if (date.isAfter(DateTime.now())) {
    //   return 'Date cannot be in the future';
    // }

    if (year < 1900) {
      return 'Year must be 1900 or later';
    }

    return null; // ✅ Valid date
  } catch (_) {
    return 'Invalid date';
  }
}
