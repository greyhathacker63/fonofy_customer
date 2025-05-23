// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class BookNowButton extends StatelessWidget {
//   const BookNowButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: SizedBox(
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: null, // Replace with actual logic to enable
//           style: ElevatedButton.styleFrom(
//
//             backgroundColor: Colors.grey.shade300,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children:   [
//                SizedBox(width: 8),
//               Text(
//                 "Book Now",
//                 style: TextStyle(color: Colors.grey),
//               ),
//               Icon(Icons.arrow_forward, color: Colors.grey),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

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
          backgroundColor: isEnabled ? Colors.grey : Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          "Book Now",
          style: TextStyle(color: isEnabled ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
