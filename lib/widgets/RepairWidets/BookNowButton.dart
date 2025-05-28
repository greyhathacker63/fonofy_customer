

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Colors.dart';



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
      width: 330,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(

          backgroundColor: ColorConstants.appBlueColor3,
          padding:   EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          "Book Now",
          style: TextStyle(color: isEnabled ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
