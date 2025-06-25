// class SellOrderDetailProduct {
//   final String? phoneNumber;
//   final String? pickupslotDate;
//   final String? pickupslotTime;
//   final String? orderId;
//   final String? shippingName;
//   final String? shippingMobileNo;
//   final String? shippingEmailId;
//   final String? shippingAddress;
//   final String? shippingLandmark;
//   final String? shippingCity;
//   final String? shippingState;
//   final String? shippingPincode;
//   final String? shippingId;
//   final String? image;
//   final String? productAndModelName;
//   final String? colorName;
//   final dynamic totalAmount;
//   final dynamic totalDiscount;
//   final dynamic totalMRP;
//   final dynamic totalPrice;
//
//   SellOrderDetailProduct({
//     this.phoneNumber,
//     this.pickupslotDate,
//     this.pickupslotTime,
//     this.orderId,
//     this.shippingName,
//     this.shippingMobileNo,
//     this.shippingEmailId,
//     this.shippingAddress,
//     this.shippingLandmark,
//     this.shippingCity,
//     this.shippingState,
//     this.shippingPincode,
//     this.shippingId,
//     this.image,
//     this.productAndModelName,
//     this.colorName,
//     this.totalAmount,
//     this.totalDiscount,
//     this.totalMRP,
//     this.totalPrice,
//   });
//
//   factory SellOrderDetailProduct.fromJson(Map<String, dynamic> json) {
//     return SellOrderDetailProduct(
//       phoneNumber: json['PhoneNumber'],
//       pickupslotDate: json['PickupslotDate'],
//       pickupslotTime: json['PickupslotTime'],
//       orderId: json['OrderId'],
//       shippingName: json['ShippingName'],
//       shippingMobileNo: json['ShippingMobileNo'],
//       shippingEmailId: json['ShippingEmailId'],
//       shippingAddress: json['ShippingAddress'],
//       shippingLandmark: json['ShippingLandmark'],
//       shippingCity: json['ShippingCity'],
//       shippingState: json['ShippingState'],
//       shippingPincode: json['ShippingPincode'],
//       shippingId: json['ShippingId'],
//       image: json['Image'],
//       productAndModelName: json['ProductAndModelName'],
//       colorName: json['ColorName'],
//       totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
//       totalDiscount: (json['TotalDiscount'] as num?)?.toDouble(),
//       totalMRP: (json['TotalMRP'] as num?)?.toDouble(),
//       totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
//     );
//   }
// }
//
// class SellOrderDetailInfo {
//   final String? customerId;
//   final String? orderId;
//   final String? orderStatus;
//   final String? pickupslotTime;
//
//   SellOrderDetailInfo({
//     this.customerId,
//     this.orderId,
//     this.orderStatus,
//     this.pickupslotTime,
//   });
//
//   factory SellOrderDetailInfo.fromJson(Map<String, dynamic> json) {
//     return SellOrderDetailInfo(
//       customerId: json['CustomerId'],
//       orderId: json['OrderId'],
//       orderStatus: json['OrderStatus'],
//       pickupslotTime: json['PickupslotTime'],
//     );
//   }
// }


// To parse this JSON data, do
//
//     final sellOrderDetailProduct = sellOrderDetailProductFromJson(jsonString);

import 'dart:convert';

SellOrderDetailProduct sellOrderDetailProductFromJson(String str) => SellOrderDetailProduct.fromJson(json.decode(str));

String sellOrderDetailProductToJson(SellOrderDetailProduct data) => json.encode(data.toJson());

class SellOrderDetailProduct {
  List<Table>? table;
  List<Table1>? table1;

  SellOrderDetailProduct({
    this.table,
    this.table1,
  });

  SellOrderDetailProduct copyWith({
    List<Table>? table,
    List<Table1>? table1,
  }) =>
      SellOrderDetailProduct(
        table: table ?? this.table,
        table1: table1 ?? this.table1,
      );

  factory SellOrderDetailProduct.fromJson(Map<String, dynamic> json) => SellOrderDetailProduct(
    table: json["Table"] == null ? [] : List<Table>.from(json["Table"]!.map((x) => Table.fromJson(x))),
    table1: json["Table1"] == null ? [] : List<Table1>.from(json["Table1"]!.map((x) => Table1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Table": table == null ? [] : List<dynamic>.from(table!.map((x) => x.toJson())),
    "Table1": table1 == null ? [] : List<dynamic>.from(table1!.map((x) => x.toJson())),
  };
}

class Table {
  String? phoneNumber;
  String? pickupslotDate;
  String? pickupslotTime;
  String? orderId;
  String? shippingName;
  String? shippingMobileNo;
  String? shippingEmailId;
  String? shippingAddress;
  String? shippingLandmark;
  String? shippingCity;
  String? shippingState;
  String? shippingPincode;
  String? shippingId;
  dynamic image;
  String? productAndModelName;
  String? colorName;
  dynamic? totalAmount;
  dynamic? totalDiscount;
  dynamic? totalMrp;
  dynamic? totalPrice;

  Table({
    this.phoneNumber,
    this.pickupslotDate,
    this.pickupslotTime,
    this.orderId,
    this.shippingName,
    this.shippingMobileNo,
    this.shippingEmailId,
    this.shippingAddress,
    this.shippingLandmark,
    this.shippingCity,
    this.shippingState,
    this.shippingPincode,
    this.shippingId,
    this.image,
    this.productAndModelName,
    this.colorName,
    this.totalAmount,
    this.totalDiscount,
    this.totalMrp,
    this.totalPrice,
  });

  Table copyWith({
    String? phoneNumber,
    String? pickupslotDate,
    String? pickupslotTime,
    String? orderId,
    String? shippingName,
    String? shippingMobileNo,
    String? shippingEmailId,
    String? shippingAddress,
    String? shippingLandmark,
    String? shippingCity,
    String? shippingState,
    String? shippingPincode,
    String? shippingId,
    dynamic image,
    String? productAndModelName,
    String? colorName,
    dynamic? totalAmount,
    dynamic? totalDiscount,
    dynamic? totalMrp,
    dynamic? totalPrice,
  }) =>
      Table(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        pickupslotDate: pickupslotDate ?? this.pickupslotDate,
        pickupslotTime: pickupslotTime ?? this.pickupslotTime,
        orderId: orderId ?? this.orderId,
        shippingName: shippingName ?? this.shippingName,
        shippingMobileNo: shippingMobileNo ?? this.shippingMobileNo,
        shippingEmailId: shippingEmailId ?? this.shippingEmailId,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        shippingLandmark: shippingLandmark ?? this.shippingLandmark,
        shippingCity: shippingCity ?? this.shippingCity,
        shippingState: shippingState ?? this.shippingState,
        shippingPincode: shippingPincode ?? this.shippingPincode,
        shippingId: shippingId ?? this.shippingId,
        image: image ?? this.image,
        productAndModelName: productAndModelName ?? this.productAndModelName,
        colorName: colorName ?? this.colorName,
        totalAmount: totalAmount ?? this.totalAmount,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalMrp: totalMrp ?? this.totalMrp,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    phoneNumber: json["PhoneNumber"],
    pickupslotDate: json["PickupslotDate"],
    pickupslotTime: json["PickupslotTime"],
    orderId: json["OrderId"],
    shippingName: json["ShippingName"],
    shippingMobileNo: json["ShippingMobileNo"],
    shippingEmailId: json["ShippingEmailId"],
    shippingAddress: json["ShippingAddress"],
    shippingLandmark: json["ShippingLandmark"],
    shippingCity: json["ShippingCity"],
    shippingState: json["ShippingState"],
    shippingPincode: json["ShippingPincode"],
    shippingId: json["ShippingId"],
    image: json["Image"],
    productAndModelName: json["ProductAndModelName"],
    colorName: json["ColorName"],
    totalAmount: json["TotalAmount"],
    totalDiscount: json["TotalDiscount"],
    totalMrp: json["TotalMRP"],
    totalPrice: json["TotalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "PhoneNumber": phoneNumber,
    "PickupslotDate": pickupslotDate,
    "PickupslotTime": pickupslotTime,
    "OrderId": orderId,
    "ShippingName": shippingName,
    "ShippingMobileNo": shippingMobileNo,
    "ShippingEmailId": shippingEmailId,
    "ShippingAddress": shippingAddress,
    "ShippingLandmark": shippingLandmark,
    "ShippingCity": shippingCity,
    "ShippingState": shippingState,
    "ShippingPincode": shippingPincode,
    "ShippingId": shippingId,
    "Image": image,
    "ProductAndModelName": productAndModelName,
    "ColorName": colorName,
    "TotalAmount": totalAmount,
    "TotalDiscount": totalDiscount,
    "TotalMRP": totalMrp,
    "TotalPrice": totalPrice,
  };
}

class Table1 {
  String? customerId;
  String? orderId;
  String? orderStatus;
  DateTime? confirmDate;
  dynamic? confirmBy;
  String? confirmRemark;
  dynamic cancelDate;
  dynamic cancelBy;
  dynamic cancelRemark;
  dynamic cancelType;
  dynamic rescheduleDate;
  dynamic reschedulelBy;
  dynamic rescheduleRemark;
  String? deliverRemark;
  DateTime? deliverDate;
  dynamic? deliverBy;
  dynamic pickupBy;
  String? pickupRemark;
  DateTime? pickupDate;
  dynamic cancelReasonId;
  dynamic cancelReasonRemark;
  dynamic reschedulelTime;
  String? pickupslotTime;

  Table1({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.confirmDate,
    this.confirmBy,
    this.confirmRemark,
    this.cancelDate,
    this.cancelBy,
    this.cancelRemark,
    this.cancelType,
    this.rescheduleDate,
    this.reschedulelBy,
    this.rescheduleRemark,
    this.deliverRemark,
    this.deliverDate,
    this.deliverBy,
    this.pickupBy,
    this.pickupRemark,
    this.pickupDate,
    this.cancelReasonId,
    this.cancelReasonRemark,
    this.reschedulelTime,
    this.pickupslotTime,
  });

  Table1 copyWith({
    String? customerId,
    String? orderId,
    String? orderStatus,
    DateTime? confirmDate,
    dynamic? confirmBy,
    String? confirmRemark,
    dynamic cancelDate,
    dynamic cancelBy,
    dynamic cancelRemark,
    dynamic cancelType,
    dynamic rescheduleDate,
    dynamic reschedulelBy,
    dynamic rescheduleRemark,
    String? deliverRemark,
    DateTime? deliverDate,
    dynamic? deliverBy,
    dynamic pickupBy,
    String? pickupRemark,
    DateTime? pickupDate,
    dynamic cancelReasonId,
    dynamic cancelReasonRemark,
    dynamic reschedulelTime,
    String? pickupslotTime,
  }) =>
      Table1(
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
        orderStatus: orderStatus ?? this.orderStatus,
        confirmDate: confirmDate ?? this.confirmDate,
        confirmBy: confirmBy ?? this.confirmBy,
        confirmRemark: confirmRemark ?? this.confirmRemark,
        cancelDate: cancelDate ?? this.cancelDate,
        cancelBy: cancelBy ?? this.cancelBy,
        cancelRemark: cancelRemark ?? this.cancelRemark,
        cancelType: cancelType ?? this.cancelType,
        rescheduleDate: rescheduleDate ?? this.rescheduleDate,
        reschedulelBy: reschedulelBy ?? this.reschedulelBy,
        rescheduleRemark: rescheduleRemark ?? this.rescheduleRemark,
        deliverRemark: deliverRemark ?? this.deliverRemark,
        deliverDate: deliverDate ?? this.deliverDate,
        deliverBy: deliverBy ?? this.deliverBy,
        pickupBy: pickupBy ?? this.pickupBy,
        pickupRemark: pickupRemark ?? this.pickupRemark,
        pickupDate: pickupDate ?? this.pickupDate,
        cancelReasonId: cancelReasonId ?? this.cancelReasonId,
        cancelReasonRemark: cancelReasonRemark ?? this.cancelReasonRemark,
        reschedulelTime: reschedulelTime ?? this.reschedulelTime,
        pickupslotTime: pickupslotTime ?? this.pickupslotTime,
      );

  factory Table1.fromJson(Map<String, dynamic> json) => Table1(
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    orderStatus: json["OrderStatus"],
    confirmDate: json["ConfirmDate"] == null ? null : DateTime.parse(json["ConfirmDate"]),
    confirmBy: json["ConfirmBy"],
    confirmRemark: json["ConfirmRemark"],
    cancelDate: json["CancelDate"],
    cancelBy: json["CancelBy"],
    cancelRemark: json["CancelRemark"],
    cancelType: json["CancelType"],
    rescheduleDate: json["RescheduleDate"],
    reschedulelBy: json["ReschedulelBy"],
    rescheduleRemark: json["RescheduleRemark"],
    deliverRemark: json["DeliverRemark"],
    deliverDate: json["DeliverDate"] == null ? null : DateTime.parse(json["DeliverDate"]),
    deliverBy: json["DeliverBy"],
    pickupBy: json["PickupBy"],
    pickupRemark: json["PickupRemark"],
    pickupDate: json["PickupDate"] == null ? null : DateTime.parse(json["PickupDate"]),
    cancelReasonId: json["CancelReasonId"],
    cancelReasonRemark: json["CancelReasonRemark"],
    reschedulelTime: json["ReschedulelTime"],
    pickupslotTime: json["PickupslotTime"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "OrderId": orderId,
    "OrderStatus": orderStatus,
    "ConfirmDate": confirmDate?.toIso8601String(),
    "ConfirmBy": confirmBy,
    "ConfirmRemark": confirmRemark,
    "CancelDate": cancelDate,
    "CancelBy": cancelBy,
    "CancelRemark": cancelRemark,
    "CancelType": cancelType,
    "RescheduleDate": rescheduleDate,
    "ReschedulelBy": reschedulelBy,
    "RescheduleRemark": rescheduleRemark,
    "DeliverRemark": deliverRemark,
    "DeliverDate": deliverDate?.toIso8601String(),
    "DeliverBy": deliverBy,
    "PickupBy": pickupBy,
    "PickupRemark": pickupRemark,
    "PickupDate": pickupDate?.toIso8601String(),
    "CancelReasonId": cancelReasonId,
    "CancelReasonRemark": cancelReasonRemark,
    "ReschedulelTime": reschedulelTime,
    "PickupslotTime": pickupslotTime,
  };
}
