// import 'dart:io';
//
// import 'package:colorful_safe_area/colorful_safe_area.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fonofy/controllers/ControllerProductDetails/test_controller.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../Controller/ordercircular_controlller/getofficeordertype.dart';
// import '../../../Controller/ordercircular_controlller/ordercircular_scontroller.dart';
// import '../../../Model/ordercircular_model/order_circular_model.dart';
// import '../../Utils/colors.dart';
//
// class OrderCircularScreen extends StatefulWidget {
//   const OrderCircularScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OrderCircularScreen> createState() => _OrderCircularScreenState();
// }
//
// class _OrderCircularScreenState extends State<OrderCircularScreen> {
//   final ScrollController _scrollController = ScrollController();
//   TextEditingController refrnceController = TextEditingController();
//   TextEditingController subjectController = TextEditingController();
//
//
//   @override
//   void initState() {
//     super.initState();
//     final controller = Provider.of<OrderCircularController>(context, listen: false);
//     final officead = Provider.of<GetOfficeOrderTypeController>(context, listen: false);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.postCircularOfficeOrder(
//         orderTypeId: 0,
//         subject: "",
//         refNo: "",
//       );
//       officead.fetchOfficeOrderType();
//     });
//
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         controller.loadMoreData(isNext: true);
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<OrderCircularController>(context);
//     double screenWidth = MediaQuery.of(context).size.width;
//     double fontSize = screenWidth * 0.04;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ColorfulSafeArea(
//         color: Colors.black,
//         child: Column(
//           children: [
//             SizedBox(height: 2),
//             Container(
//               height: 35,
//               color: SecondryColor,
//               child: Center(
//                 child: Text(
//                   "Order / Circular",
//                   style: TextStyle(
//                     fontSize: fontSize,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Type",
//                               style: TextStyle(fontSize: 16, color: Colors.black),
//                             ),
//                             SizedBox(height: 8),
//                             Consumer<GetOfficeOrderTypeController>(
//                               builder: (context, controller, child) {
//                                 return Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: DropdownButton<int>(
//                                     isExpanded: true,
//                                     value: controller.selectedid,
//                                     hint: Text("Select One"),
//                                     items: controller.dropdownItems.map((item) {
//                                       return DropdownMenuItem<int>(
//                                         value: item.id,
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(item.name),
//                                             if (controller.selectedid != item.id)
//                                               Divider( color: Colors.black),
//                                           ],
//                                         ),
//                                       );
//                                     }).toList(),
//                                     onChanged: (value) {
//                                       if (value != null) {
//                                         controller.setSelectedId(value);
//                                       }
//                                     },
//                                     underline: SizedBox(),
//                                     // Center the selected value
//                                     selectedItemBuilder: (BuildContext context) {
//                                       return controller.dropdownItems.map<Widget>((item) {
//                                         return Align(
//                                           alignment: Alignment.center, // Center the text
//                                           child: Text(item.name),
//                                         );
//                                       }).toList();
//                                     },
//                                   ),
//                                 );
//
//
//
//
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Ref.No",
//                               style: TextStyle(fontSize: 16, color: Colors.black),
//                             ),
//                             SizedBox(height: 8),
//                             Container(
//                               height: 50,
//                               child: TextFormField(
//                                 controller: refrnceController,
//                                 cursorColor: Colors.black,
//                                 decoration: InputDecoration(
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide(color: Colors.black, width: 2),
//                                   ),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                       borderSide: BorderSide()),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(child:
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//
//                               children: [
//                                 Text(
//                                   "Subject",
//                                   style: TextStyle(fontSize: 16, color: Colors.black),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Container(
//                                   height: 50,
//                                   child: TextFormField(
//                                     controller: subjectController,
//                                     cursorColor: Colors.black,
//                                     maxLines: 1,
//                                     decoration: InputDecoration(
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(color: Colors.black, width: 2),
//                                       ),
//                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//
//                             Expanded(child:
//                             Center(
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: 30,),
//                                   ElevatedButton(
//                                     style: ButtonStyle(
//                                       shape: MaterialStateProperty.all(
//                                         RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(5),
//                                         ),
//                                       ),
//                                       backgroundColor: MaterialStateProperty.all(Colors.black),
//                                     ),
//                                     onPressed: () {
//                                       String refNo = refrnceController.text.trim();
//                                       String subject = subjectController.text.trim();
//                                       final _selectedId = context.read<GetOfficeOrderTypeController>().selectedid ?? 0;
//
//                                       print(" this is selcted id number ${_selectedId}");
//
//
//                                       controller.postCircularOfficeOrder(
//                                         orderTypeId: _selectedId,
//                                         subject: subject,
//                                         refNo: refNo,
//                                       );
//
//
//                                     },
//                                     child: Text(
//                                       "Search",
//                                       style: TextStyle(fontSize: 16, color: Colors.white),
//                                     ),
//                                   ),
//                                 ],),
//                             ))
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Stack(
//                 children: [
//                   if (controller.orderCircularModel == null)
//                     Shimmer.fromColors(
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: ListView.separated(
//                         itemCount: 10,
//                         separatorBuilder: (context, index) => Divider(
//                           thickness: 1,
//                           height: 1,
//                           color: Colors.grey,
//                         ),
//                         itemBuilder: (context, index) => ListTile(
//                           contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
//                           title: Container(
//                             width: double.infinity,
//                             height: 10,
//                             color: Colors.white,
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 100,
//                                 height: 8,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(height: 2),
//                               Container(
//                                 width: 120,
//                                 height: 8,
//                                 color: Colors.white,
//                               ),
//                               SizedBox(height: 2),
//                               Container(
//                                 width: 150,
//                                 height: 8,
//                                 color: Colors.white,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   else if (controller.orderCircularModel?.circularOfficeOrderList.isEmpty ?? true)
//                     Center(
//                       child: Text(
//                         "No data found.",
//                         style: TextStyle(color: Colors.grey, fontSize: fontSize),
//                       ),
//                     )
//                   else
//                     ListView.separated(
//                       controller: _scrollController,
//                       itemCount: controller.orderCircularModel?.circularOfficeOrderList.length ?? 0,
//                       separatorBuilder: (context, index) => Divider(
//                         thickness: 1,
//                         height: 1,
//                         color: Colors.black,
//                       ),
//                       itemBuilder: (context, index) {
//                         final item = controller.orderCircularModel!.circularOfficeOrderList[index];
//                         return ListTile(
//
//                           onTap: () async {
//                             final fileUrl = item.filePath.replaceAll(r'\\', '/');
//                             final fileName = fileUrl.split('/').last;
//
//                             String? action = await showDialog<String>(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('File Options'),
//                                   content: Text('What do you want to do with "$fileName"?'),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop('view');
//                                       },
//                                       child: Text('Downloade or View'),
//                                     ),
//
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop(null);
//                                       },
//                                       child: Text('Cancel'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//
//                             if (action == 'view') {
//                               try {
//                                 // Open file in browser or viewer
//                                 await launchUrl(Uri.parse(fileUrl));
//                               } catch (e) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Could not open file. Error: $e')),
//                                 );
//                               }
//                             }
//                           },
//
//
//
//
//                           contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
//                           title: Container(
//                             width: double.infinity,
//                           ),
//                           subtitle: Padding(
//                             padding: EdgeInsets.only(bottom: 8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(right: 8.0),
//                                       child: RichText(
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text: "Date:",
//                                               style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black, fontWeight: FontWeight.bold),
//                                             ),
//                                             TextSpan(
//                                               text: " ${item.circulardate}",
//                                               style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: RichText(
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                               text: "Category: ",
//                                               style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black, fontWeight: FontWeight.bold),
//                                             ),
//                                             TextSpan(
//                                               text: "${item.officeOrderCatgName}",
//                                               style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black),
//                                             ),
//                                           ],
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 4),
//                                 RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: "Ref. No: ",
//                                         style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black, fontWeight: FontWeight.bold),
//                                       ),
//                                       TextSpan(
//                                         text: "${item.refrenceNo}",
//                                         style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: "Subject: ",
//                                         style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black, fontWeight: FontWeight.bold),
//                                       ),
//                                       TextSpan(
//                                         text: "${item.circularSubject}",
//                                         style: TextStyle(fontSize: fontSize * 0.8, color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }