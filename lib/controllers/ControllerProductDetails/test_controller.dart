// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../../Model/ordercircular_model/order_circular_model.dart';
//
// class OrderCircularController extends ChangeNotifier {
//   bool isLoading = false;
//   String? errorMessage;
//   OrderCircularModel? orderCircularModel;
//   int pagingNumber = 0;
//   int pageSize = 20;
//   List<CircularOfficeOrderList> circularOfficeOrderList = [];
//
//   Future<void> postCircularOfficeOrder({
//     required int orderTypeId,
//     required String subject,
//     required String refNo,
//     int pagingNumber = 0,
//     int pageSize = 20,
//   }) async {
//     const String url = 'https://pwdonline.calibre.net.in/Api/OfficeOder/PostCircularOfficeOrder';
//     final requestBody = [{
//       "OrderTypeId": orderTypeId,
//       "Subject": subject,
//       "RefNo": refNo,
//       "AppLoginId": "PWDonline",
//       "AppPassword": "PWDonlineapp!\$1@7V3*App",
//       "WSName": "PostCircularOfficeOrder",
//       "pagingNumber": pagingNumber,
//       "pageSize": pageSize,
//     }];
//
//     try {
//       isLoading = true;
//       errorMessage = null;
//       notifyListeners();
//
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "text/plain"},
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final newOrders = OrderCircularModel.fromJson(data).circularOfficeOrderList;
//
//         if (pagingNumber == 0) {
//           orderCircularModel = OrderCircularModel.fromJson(data);
//         } else {
//           orderCircularModel?.circularOfficeOrderList.addAll(newOrders);
//         }
//
//         notifyListeners();
//       } else {
//         errorMessage = 'Failed to post data: ${response.reasonPhrase}';
//         notifyListeners();
//       }
//     } catch (e) {
//       errorMessage = 'An error occurred: $e';
//       notifyListeners();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//
//   Future<void> loadMoreData({bool isNext = true}) async {
//     if (isLoading) return;
//
//     if (isNext) {
//       pagingNumber += pageSize;
//     } else {
//       pagingNumber = pagingNumber > 0 ? pagingNumber - pageSize : 0;
//     }
//
//     await postCircularOfficeOrder(
//       orderTypeId: 0,
//       subject: "",
//       refNo: "",
//       pagingNumber: pagingNumber,
//       pageSize: pageSize,
//     );
//   }
// }