

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ColorConstants/Colors.dart';



class BookNowButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BookNowButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? ColorConstants.appBlueColor3
              : Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: isEnabled ? 3 : 0,
          padding:   EdgeInsets.symmetric(vertical: 13),
        ),
        child: Text("Book Now",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
