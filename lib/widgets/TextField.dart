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
  final int? maxLine;
  final String? Function(String?)? validator; // ✅ Add validator

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
    this.maxLine,
    this.validator, // ✅ Accept validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        autocorrect: autoCorrect,
        textCapitalization: capitalize ? TextCapitalization.words : TextCapitalization.none,
        maxLength: maxLength,
        maxLines: maxLine,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        validator: validator, // ✅ Apply validation
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
          counterText: "", // ✅ Hide character count
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
      ),
    );
  }
}
