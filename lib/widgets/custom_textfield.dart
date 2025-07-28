import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final double? boxWidth;
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onSuffixPressed;
  final double? boxHeight;
  final int? maxline;
  final double boderRadius;

  const CustomTextInput(
      {super.key,
      required this.controller,
      this.label,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.validator,
      this.onChanged,
      this.onTap,
      this.inputFormatters,
      this.fillColor,
      this.boxWidth,
      this.onPrefixPressed,
      this.onSuffixPressed,
      this.boxHeight,
      this.boderRadius = 30,
      this.maxline});

  @override
  Widget build(BuildContext context) {
    final constrainedWidth = boxWidth ?? MediaQuery.of(context).size.width;
    final constrainedHeight = boxHeight ?? 50;
    return SizedBox(
      width: constrainedWidth,
      height: constrainedHeight, // fallback to full width if not provided
      child: TextFormField(
        maxLength: maxLines > 1 ? null : maxline,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          errorStyle: const TextStyle(height: 1.2),
          fillColor: fillColor ?? Colors.white,
          hintText: hintText ?? "Enter $label",
          prefixIcon: prefixIcon != null
              ? (onPrefixPressed != null
                  ? IconButton(
                      icon: Icon(prefixIcon),
                      onPressed: onPrefixPressed,
                    )
                  : Icon(prefixIcon))
              : null,
          suffixIcon: suffixIcon != null
              ? (onSuffixPressed != null
                  ? IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onSuffixPressed,
                    )
                  : Icon(suffixIcon))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(boderRadius),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class IndianCurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String unformatted = newValue.text.replaceAll(',', '');

    if (unformatted.isEmpty) return newValue;

    // Only allow digits and optionally one decimal point with max 2 decimals
    final validPattern = RegExp(r'^\d+\.?\d{0,2}$');
    if (!validPattern.hasMatch(unformatted)) return oldValue;

    // Split into integer and decimal parts
    List<String> parts = unformatted.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    String formattedInteger = _formatIndianNumber(integerPart);

    String result = decimalPart.isNotEmpty
        ? '$formattedInteger.$decimalPart'
        : formattedInteger;

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }

  String _formatIndianNumber(String input) {
    if (input.length <= 3) return input;

    String lastThree = input.substring(input.length - 3);
    String rest = input.substring(0, input.length - 3);
    StringBuffer buffer = StringBuffer();

    List<String> reversed = rest.split('').reversed.toList();
    for (int i = 0; i < reversed.length; i++) {
      if (i != 0 && i % 2 == 0) buffer.write(',');
      buffer.write(reversed[i]);
    }

    String formattedRest = buffer.toString().split('').reversed.join('');
    return '$formattedRest,$lastThree';
  }
}

class LoanCalculatorRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final double? boxWidth;
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onSuffixPressed;
  final double? boxHeight;
  final double? fontSize;

  const LoanCalculatorRow(
      {super.key,
      required this.controller,
      required this.label,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.readOnly = false,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.validator,
      this.onChanged,
      this.onTap,
      this.inputFormatters,
      this.fillColor,
      this.boxWidth,
      this.onPrefixPressed,
      this.onSuffixPressed,
      this.boxHeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              textAlign: TextAlign.justify,
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: fontSize ?? 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextInput(
              fillColor: fillColor ?? Colors.cyan.shade100,
              controller: controller,
              inputFormatters: inputFormatters ??
                  [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
              label: "", // External label
              hintText: hintText ?? "Enter $label",
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              onPrefixPressed: onPrefixPressed,
              onSuffixPressed: onSuffixPressed,
              obscureText: obscureText,
              readOnly: readOnly,
              keyboardType: keyboardType,
              maxLines: maxLines,
              validator: validator,
              onChanged: onChanged,
              onTap: onTap,
              boxWidth: boxWidth,
            ),
          ),
        ],
      ),
    );
  }
}

TableRow buildTabelRow(
    String label, TextEditingController controller, bool readOnly,
    {IconData? prefixIcon, IconData? suffixIcon, String? hinttext}) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(5),
      child: CustomTextInput(
        controller: controller,
        hintText: hinttext ?? label,
        readOnly: readOnly,
        fillColor: Colors.greenAccent,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    ),
  ]);
}
