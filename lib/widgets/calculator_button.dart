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
    this.buttonColor = Colors.blue,
    this.buttonWidth = 150,
    this.buttonHeight = 50,
    this.iconSize = 24,
    this.textColor = Colors.white,
    this.textSize = 16,
    this.fontWeight = FontWeight.normal,
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
          if (icon != null)
          Icon(icon, size: iconSize, color: textColor),
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


class CustomIconSwitch extends StatefulWidget {
  final Icon onIcon;
  final Icon offIcon;
  final Color onColor;
  final Color offColor;
  final double? buttonHeight;
  final double? buttonWidth;

  const CustomIconSwitch({
    super.key,
    required this.onIcon,
    required this.offIcon,
    this.onColor = Colors.green,
    this.offColor = Colors.green,
    this.buttonHeight,
    this.buttonWidth,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomIconSwitchState createState() => _CustomIconSwitchState();
}

class _CustomIconSwitchState extends State<CustomIconSwitch> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOn = !isOn;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.buttonWidth ?? 50,
        height: widget.buttonHeight ?? 27,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isOn ? Colors.green : const Color.fromARGB(255, 27, 26, 26),
        ),
        child: Row(
          mainAxisAlignment:
              isOn ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isOn ? widget.onIcon : widget.offIcon,
            ),
          ],
        ),
      ),
    );
  }
}
