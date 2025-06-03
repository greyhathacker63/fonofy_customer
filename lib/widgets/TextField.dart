import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool autoCorrect;
  final bool capitalize;
  final int? maxLength;
  final bool obscureText ;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final IconData? prefixIcon;
  final int? maxLine;
   final Widget? suffixIcon;
  final InputBorder? border;
  final VoidCallback? onTogglePassword;
   final String? Function(String?)? validator;

  const GlobalTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.autoCorrect = true,
    this.capitalize = false,
    this.obscureText = false,
    this.onTogglePassword,
    this.maxLength,
    this.prefixText,
    this.prefixStyle,
    this.prefixIcon,
    this.maxLine,
    this.validator,
    this.suffixIcon,
    this.border,

  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText, // ✅ Fixed line here
        autocorrect: autoCorrect,
        textCapitalization: capitalize ? TextCapitalization.words : TextCapitalization.none,
        maxLength: maxLength,
        maxLines: maxLine,
        validator: validator,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: hint,
          prefixText: prefixText,
          prefixStyle: prefixStyle,
          border: OutlineInputBorder(),
          suffixIcon: suffixIcon, // ✅ Add this
          counterText: "",
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        ),
      ),
    );
  }
}
