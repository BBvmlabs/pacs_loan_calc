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
  final VoidCallback? onPrefixPressed;
  final VoidCallback? onSuffixPressed;
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
    this.boxWidth,
    this.onPrefixPressed,
    this.onSuffixPressed,
    this.boxHeight,
  });

  @override
@override
Widget build(BuildContext context)
 {
  final constrainedWidth = boxWidth ?? MediaQuery.of(context).size.width;
  final constrainedHeight = boxHeight ?? 40;
  return SizedBox(
    width: constrainedWidth,
    height: constrainedHeight, // fallback to full width if not provided
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
        filled: true,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        fillColor: fillColor ?? Colors.white,
        hintText: hintText,
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
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
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


  const LoanCalculatorRow({
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
    this.boxWidth,
    this.onPrefixPressed,
    this.onSuffixPressed,
    this.boxHeight,
    this.fontSize

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            // width: 130,
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


class LoanCalculatorColumn extends StatelessWidget {
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
  final double? fontSize;

  const LoanCalculatorColumn({
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
    this.boxWidth,
    this.onPrefixPressed,
    this.onSuffixPressed,
    this.fontSize
  });

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          // width: 130,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 16,
            ),
          ),
        ),
        const SizedBox(height: 8), // spacing between label and input
        SizedBox(
          width: boxWidth ?? 130,
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