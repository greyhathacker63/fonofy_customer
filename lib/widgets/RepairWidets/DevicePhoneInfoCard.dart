import 'package:flutter/cupertino.dart';
import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';

// class DevicePhoneInfoCard extends StatelessWidget {
//   const DevicePhoneInfoCard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF6F6F6),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Apple iPhone SE 2022", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 SizedBox(height: 10),
//                 Text("Color: Midnight"),
//                 SizedBox(height: 6),
//                 // Row(
//                 //   children: [
//                 //     Icon(Icons.circle, size: 2),
//                 //     SizedBox(width: 3),
//                 //     Text("Certified Parts"),
//                 //     SizedBox(width: 3),
//                 //     Icon(Icons.circle, size: 2),
//                 //     SizedBox(width: 3),
//                 //     Text("Instant Repair"),
//                 //     SizedBox(width: 3),
//                 //     Icon(Icons.circle, size: 2),
//                 //     SizedBox(width: 3),
//                 //     Text("Trusted Brand"),
//                 //   ],
//                 // )
//               ],
//             ),
//           ),
//           SizedBox(width: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.asset("assets/images/Repair_phone.png", height: 80),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class DevicePhoneInfoCard extends StatefulWidget {
  final List<RepairDeviceTable>? repairTable;

  const DevicePhoneInfoCard({super.key, required this.repairTable});

  @override
  _DevicePhoneInfoCardState createState() => _DevicePhoneInfoCardState();
}

class _DevicePhoneInfoCardState extends State<DevicePhoneInfoCard> {
  @override
  Widget build(BuildContext context) {
    final hasData = widget.repairTable != null && widget.repairTable!.isNotEmpty;

    if (!hasData) {
      return const Center(child: Text("No Device Info Available"));
    }

    // Since repairTable typically has one item, use the first item
    final device = widget.repairTable!.first;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.productAndModelName ?? " ",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text("Color: ${device.colorName ?? ''}"),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/Repair_phone.png",
              height: 80,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 80),
            ),
          ),
        ],
      ),
    );
  }
}
