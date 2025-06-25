import 'package:flutter/material.dart';

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
