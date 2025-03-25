// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class AddressScreen5 extends StatefulWidget {
//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }
//
// class _AddressScreenState extends State<AddressScreen5> {
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController houseController = TextEditingController();
//   final TextEditingController localityController = TextEditingController();
//   final TextEditingController landmarkController = TextEditingController();
//   final TextEditingController alternateNumberController = TextEditingController();
//
//   String selectedAddressType = "Other";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               "Address",style: TextStyle(color: Colors.black),
//             ),
//             const SizedBox(width: 170),
//             const Icon(Icons.clear_rounded, color: Colors.black),
//           ],
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Use My Current Location Button
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.my_location, color: Colors.black54),
//                     const SizedBox(width: 10),
//                     const Text(
//                       "Use my current location",
//                       style: TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildTextField("Enter Pincode*", pincodeController, TextInputType.number),
//               _buildTextField("Flat no./H no./Office*", houseController),
//               _buildTextField("Locality/Area/Street", localityController),
//
//               _buildTextField("Landmark (optional)", landmarkController),
//
//               _buildTextField("Alternate number (optional)", alternateNumberController, TextInputType.phone),
//
//               const SizedBox(height: 10),
//               const Text("Save As", style: TextStyle(fontWeight: FontWeight.w500)),
//
//               // Save As Options (Radio Buttons)
//               Row(
//                 children: [
//                   _buildRadioOption("Home"),
//                   _buildRadioOption("Office"),
//                   _buildRadioOption("Other"),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               // Continue Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print("Address Saved");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: const Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget _buildTextField(
//       String label, TextEditingController controller,
//       [TextInputType keyboardType = TextInputType.text, int? maxLength]) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         inputFormatters: maxLength != null
//             ? [
//           LengthLimitingTextInputFormatter(maxLength),
//           FilteringTextInputFormatter.digitsOnly,
//         ]
//             : null,
//         decoration: InputDecoration(
//           labelText: label,
//         ),
//       ),
//     );
//   }
//
//   // Reusable Radio Button Option
//   Widget _buildRadioOption(String value) {
//     return Expanded(
//       child: Row(
//         children: [
//           Radio(
//             value: value,
//             groupValue: selectedAddressType,
//             onChanged: (newValue) {
//               setState(() {
//                 selectedAddressType = newValue.toString();
//               });
//             },
//           ),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
