import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onClicked;
  final Color buttonColor;
  final IconData? icon;
  final double buttonWidth;
  final double buttonHeight;
  final double iconSize;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onClicked,
    this.buttonColor = const Color(0xFF2E7D32),
    this.buttonWidth = 150,
    this.buttonHeight = 50,
    this.iconSize = 24,
    this.textColor = Colors.black87,
    this.textSize = 20,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all<Size>(
          Size(buttonWidth, buttonHeight),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 12.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: iconSize, color: textColor),
          if (icon != null && text != null) const SizedBox(width: 8),
          if (text != null) ...[
            Text(
              text!,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class CustomIconSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Icon onIcon;
  final Icon offIcon;
  final Color onColor;
  final Color offColor;
  final double? buttonHeight;
  final double? buttonWidth;

  const CustomIconSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onIcon,
    required this.offIcon,
    this.onColor = Colors.green,
    this.offColor = Colors.grey,
    this.buttonHeight,
    this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: buttonWidth ?? 50,
        height: buttonHeight ?? 27,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: value ? onColor : offColor,
        ),
        child: Row(
          mainAxisAlignment:
              value ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: value ? onIcon : offIcon,
            ),
          ],
        ),
      ),
    );
  }
}

Widget backButton(context) {
  return IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back),
    style: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
        iconSize: WidgetStatePropertyAll(25)),
  );
}
