import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool autoCorrect;
  final bool capitalize;
  final int? maxLength;
  final IconData? prefixIcon;

  const GlobalTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.autoCorrect = true,
    this.capitalize = false,
    this.maxLength,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        autocorrect: autoCorrect,
        textCapitalization: capitalize ? TextCapitalization.words : TextCapitalization.none,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
          counterText: "", // Hide character count
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
      ),
    );
  }
}
