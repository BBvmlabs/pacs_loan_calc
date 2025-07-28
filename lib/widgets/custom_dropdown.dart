import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final Color textColor;
  final Color dropdownColor;
  final String hintText;

  const CustomDropDown(
      {super.key,
      required this.items,
      this.textColor = Colors.black,
      this.dropdownColor = Colors.white,
      this.hintText = "Select"});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.isNotEmpty ? widget.items[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      hint: Text(widget.hintText, style: TextStyle(color: widget.textColor)),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: TextStyle(color: widget.textColor)),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      dropdownColor: widget.dropdownColor,
    );
  }
}
