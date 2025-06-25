import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final Color testColor;
  final Color dropdownColor;

  const CustomDropDown({super.key, 
  required this.items,
  this.testColor = Colors.black,
  this.dropdownColor = Colors.white
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}