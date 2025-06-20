// To parse this JSON data, do
//
//     final repairOrderProductDetailsModel = repairOrderProductDetailsModelFromJson(jsonString);

import 'dart:convert';

RepairOrderProductDetailsModel repairOrderProductDetailsModelFromJson(String str) => RepairOrderProductDetailsModel.fromJson(json.decode(str));

String repairOrderProductDetailsModelToJson(RepairOrderProductDetailsModel data) => json.encode(data.toJson());

class RepairOrderProductDetailsModel {
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;

  RepairOrderProductDetailsModel({
    this.table,
    this.table1,
    this.table2,
  });

  RepairOrderProductDetailsModel copyWith({
    List<Table>? table,
    List<Table1>? table1,
    List<Table2>? table2,
  }) =>
      RepairOrderProductDetailsModel(
        table: table ?? this.table,
        table1: table1 ?? this.table1,
        table2: table2 ?? this.table2,
      );

  factory RepairOrderProductDetailsModel.fromJson(Map<String, dynamic> json) => RepairOrderProductDetailsModel(
    table: json["Table"] == null ? [] : List<Table>.from(json["Table"]!.map((x) => Table.fromJson(x))),
    table1: json["Table1"] == null ? [] : List<Table1>.from(json["Table1"]!.map((x) => Table1.fromJson(x))),
    table2: json["Table2"] == null ? [] : List<Table2>.from(json["Table2"]!.map((x) => Table2.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Table": table == null ? [] : List<dynamic>.from(table!.map((x) => x.toJson())),
    "Table1": table1 == null ? [] : List<dynamic>.from(table1!.map((x) => x.toJson())),
    "Table2": table2 == null ? [] : List<dynamic>.from(table2!.map((x) => x.toJson())),
  };
}

class Table {
  String? phoneNumber;
  String? slotDate;
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
    this.slotDate,
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
    String? slotDate,
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
        slotDate: slotDate ?? this.slotDate,
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
    slotDate: json["SlotDate"],
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
    "SlotDate": slotDate,
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
  dynamic serviceAmount;
  dynamic serviceDiscount;
  dynamic servicePercent;
  dynamic serviceId;
  String? serviceName;
  DateTime? createdDate;

  Table1({
    this.customerId,
    this.orderId,
    this.serviceAmount,
    this.serviceDiscount,
    this.servicePercent,
    this.serviceId,
    this.serviceName,
    this.createdDate,
  });

  Table1 copyWith({
    String? customerId,
    String? orderId,
    dynamic? serviceAmount,
    dynamic? serviceDiscount,
    dynamic? servicePercent,
    dynamic? serviceId,
    String? serviceName,
    DateTime? createdDate,
  }) =>
      Table1(
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
        serviceAmount: serviceAmount ?? this.serviceAmount,
        serviceDiscount: serviceDiscount ?? this.serviceDiscount,
        servicePercent: servicePercent ?? this.servicePercent,
        serviceId: serviceId ?? this.serviceId,
        serviceName: serviceName ?? this.serviceName,
        createdDate: createdDate ?? this.createdDate,
      );

  factory Table1.fromJson(Map<String, dynamic> json) => Table1(
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    serviceAmount: json["ServiceAmount"],
    serviceDiscount: json["ServiceDiscount"],
    servicePercent: json["ServicePercent"],
    serviceId: json["ServiceId"],
    serviceName: json["ServiceName"],
    createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "OrderId": orderId,
    "ServiceAmount": serviceAmount,
    "ServiceDiscount": serviceDiscount,
    "ServicePercent": servicePercent,
    "ServiceId": serviceId,
    "ServiceName": serviceName,
    "CreatedDate": createdDate?.toIso8601String(),
  };
}

class Table2 {
  dynamic assignId;
  dynamic assignDate;
  dynamic assignRemark;
  dynamic assignBy;
  String? workType;
  dynamic rescheduleRemark;
  dynamic reschedulelBy;
  dynamic rescheduleDate;
  dynamic cancelType;
  dynamic cancelRemark;
  dynamic cancelBy;
  dynamic cancelDate;
  dynamic confirmRemark;
  dynamic confirmBy;
  dynamic confirmDate;
  String? paymentStatus;
  dynamic? totalMrp;
  dynamic? totalDiscount;
  dynamic? totalPrice;
  dynamic? deliveryCharge;
  String? remark;
  dynamic? totalAmount;
  String? customerId;
  String? orderId;

  Table2({
    this.assignId,
    this.assignDate,
    this.assignRemark,
    this.assignBy,
    this.workType,
    this.rescheduleRemark,
    this.reschedulelBy,
    this.rescheduleDate,
    this.cancelType,
    this.cancelRemark,
    this.cancelBy,
    this.cancelDate,
    this.confirmRemark,
    this.confirmBy,
    this.confirmDate,
    this.paymentStatus,
    this.totalMrp,
    this.totalDiscount,
    this.totalPrice,
    this.deliveryCharge,
    this.remark,
    this.totalAmount,
    this.customerId,
    this.orderId,
  });

  Table2 copyWith({
    dynamic assignId,
    dynamic assignDate,
    dynamic assignRemark,
    dynamic assignBy,
    String? workType,
    dynamic rescheduleRemark,
    dynamic reschedulelBy,
    dynamic rescheduleDate,
    dynamic cancelType,
    dynamic cancelRemark,
    dynamic cancelBy,
    dynamic cancelDate,
    dynamic confirmRemark,
    dynamic confirmBy,
    dynamic confirmDate,
    String? paymentStatus,
    dynamic? totalMrp,
    dynamic? totalDiscount,
    dynamic? totalPrice,
    dynamic? deliveryCharge,
    String? remark,
    dynamic? totalAmount,
    String? customerId,
    String? orderId,
  }) =>
      Table2(
        assignId: assignId ?? this.assignId,
        assignDate: assignDate ?? this.assignDate,
        assignRemark: assignRemark ?? this.assignRemark,
        assignBy: assignBy ?? this.assignBy,
        workType: workType ?? this.workType,
        rescheduleRemark: rescheduleRemark ?? this.rescheduleRemark,
        reschedulelBy: reschedulelBy ?? this.reschedulelBy,
        rescheduleDate: rescheduleDate ?? this.rescheduleDate,
        cancelType: cancelType ?? this.cancelType,
        cancelRemark: cancelRemark ?? this.cancelRemark,
        cancelBy: cancelBy ?? this.cancelBy,
        cancelDate: cancelDate ?? this.cancelDate,
        confirmRemark: confirmRemark ?? this.confirmRemark,
        confirmBy: confirmBy ?? this.confirmBy,
        confirmDate: confirmDate ?? this.confirmDate,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        totalMrp: totalMrp ?? this.totalMrp,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalPrice: totalPrice ?? this.totalPrice,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        remark: remark ?? this.remark,
        totalAmount: totalAmount ?? this.totalAmount,
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
      );

  factory Table2.fromJson(Map<String, dynamic> json) => Table2(
    assignId: json["AssignId"],
    assignDate: json["AssignDate"],
    assignRemark: json["AssignRemark"],
    assignBy: json["AssignBy"],
    workType: json["WorkType"],
    rescheduleRemark: json["RescheduleRemark"],
    reschedulelBy: json["ReschedulelBy"],
    rescheduleDate: json["RescheduleDate"],
    cancelType: json["CancelType"],
    cancelRemark: json["CancelRemark"],
    cancelBy: json["CancelBy"],
    cancelDate: json["CancelDate"],
    confirmRemark: json["ConfirmRemark"],
    confirmBy: json["ConfirmBy"],
    confirmDate: json["ConfirmDate"],
    paymentStatus: json["PaymentStatus"],
    totalMrp: json["TotalMRP"],
    totalDiscount: json["TotalDiscount"],
    totalPrice: json["TotalPrice"],
    deliveryCharge: json["DeliveryCharge"],
    remark: json["Remark"],
    totalAmount: json["TotalAmount"],
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
  );

  Map<String, dynamic> toJson() => {
    "AssignId": assignId,
    "AssignDate": assignDate,
    "AssignRemark": assignRemark,
    "AssignBy": assignBy,
    "WorkType": workType,
    "RescheduleRemark": rescheduleRemark,
    "ReschedulelBy": reschedulelBy,
    "RescheduleDate": rescheduleDate,
    "CancelType": cancelType,
    "CancelRemark": cancelRemark,
    "CancelBy": cancelBy,
    "CancelDate": cancelDate,
    "ConfirmRemark": confirmRemark,
    "ConfirmBy": confirmBy,
    "ConfirmDate": confirmDate,
    "PaymentStatus": paymentStatus,
    "TotalMRP": totalMrp,
    "TotalDiscount": totalDiscount,
    "TotalPrice": totalPrice,
    "DeliveryCharge": deliveryCharge,
    "Remark": remark,
    "TotalAmount": totalAmount,
    "CustomerId": customerId,
    "OrderId": orderId,
  };
}
