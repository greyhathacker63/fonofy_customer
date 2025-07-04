import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/pages/AuthScreens/LoginScreen/LoginScreen.dart';
import 'package:fonofy/models/RepairServicesTableModel/RepairServicesTableModel.dart';

import '../ColorConstants/Colors.dart';

// class ServicePhoneItem extends StatelessWidget {
//   final String icon;
//   final String title;
//   final int discount;
//   final int price;
//   final int original;
//   final String? note;
//
//   const ServicePhoneItem({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.discount,
//     required this.price,
//     required this.original,
//     this.note,
//   });
//
//   @override
//   Widget build(BuildContext context ) {
//     return SizedBox(
//       width: 330,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               Image.asset(icon, height: 40, width: 40),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Text('-$discount%', style: const TextStyle(color: Colors.red)),
//                         const SizedBox(width: 8),
//                         Text('₹$price', style: const TextStyle(fontWeight: FontWeight.bold)),
//                         const SizedBox(width: 6),
//                         Text(
//                           '₹$original',
//                           style: const TextStyle(
//                             decoration: TextDecoration.lineThrough,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                 child:   Text("Add +",style: TextStyle(color: Colors.white,fontSize: 13),),
//               )
//             ],
//           ),
//           if (note != null)
//             Container(
//               margin:   EdgeInsets.only(top: 20),
//               padding:   EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color:   Color(0xFFFFF3E0),
//                 borderRadius: BorderRadius.circular(9),
//               ),
//               child: Text(note!, style:   TextStyle(fontSize: 11)),
//             ),
//           const Divider(height: 32),
//         ],
//       ),
//     );
//   }
// }
class ServicePhoneItem extends StatelessWidget {
  final String image;
  final String title;
  final int discount;
  final int price;
  final int mrp;
  final String? note;
  final List<Table1>? repairTable1;

  const ServicePhoneItem({
    super.key,
    required this.image,
    required this.title,
    required this.discount,
    required this.price,
    required this.mrp,
    this.note, this.repairTable1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.network(image, height: 40, width: 40),
                SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style:   TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('$discount%', style: const TextStyle(color: Colors.red)),
                        const SizedBox(width: 8),
                        Text('₹$price', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 6),
                        Text(' ₹$mrp',
                          style:   TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                SizedBox(width: 10),
    Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
        onPressed: () async {

         final token = TokenHelper.getToken();
          if (token == null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
          } else {
            Navigator.pushNamed(context, '/selectServices');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.appBlueColor3,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "Add +",
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    )

            ],
          ),
          if (note != null)
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(note!, style: const TextStyle(fontSize: 11)),
            ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}