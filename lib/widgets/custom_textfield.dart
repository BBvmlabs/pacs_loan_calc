import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
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
  final double? boxHeight;

  const CustomTextInput({
    super.key,
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
    this.boxHeight,
    this.boxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: fillColor),
          height: boxHeight,
          width: boxWidth,
          child: TextFormField(
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
              fillColor: Colors.black,
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ));
  }
}

class LoanCalculatorRow extends StatefulWidget {
  final String? label;

  const LoanCalculatorRow({super.key, this.label});

  @override
  State<LoanCalculatorRow> createState() => _LoanCalculatorRowState();
}

class _LoanCalculatorRowState extends State<LoanCalculatorRow> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const SizedBox(height: 20),
            const Text(
              data: lable,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 50),
            CustomTextInput(
              fillColor: Colors.cyan,
              boxHeight: 50,
              boxWidth: 160,
              controller: amountController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))
              ],
              label: "Loan Amount",
              hintText: "Enter amount",
              prefixIcon: Icons.currency_rupee,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return "Required";
                return null;
              },
            ),
          ],
        )
      ]),
    );
  }
}
