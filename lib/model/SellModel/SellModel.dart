// To parse this JSON data, do
//
//     final sellModel = sellModelFromJson(jsonString);

import 'dart:convert';

List<SellModel> sellModelFromJson(String str) => List<SellModel>.from(json.decode(str).map((x) => SellModel.fromJson(x)));

String sellModelToJson(List<SellModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellModel {
  String? customerId;
  String? orderId;
  String? orderStatus;
  dynamic? totalMrp;
  dynamic? totalDiscount;
  dynamic? totalPrice;
  String? createdDate;
  DateTime? createdDates;
  String? confirmDate;
  dynamic? confirmBy;
  String? confirmRemark;
  String? cancelDate;
  dynamic? cancelBy;
  dynamic cancelRemark;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? shippingLandmark;
  String? shippingName;
  String? shippingMobileNo;
  String? shippingEmailId;
  String? shippingPincode;
  dynamic? totalAmount;
  String? customerName;
  String? mobileNo;
  String? emailId;
  dynamic pickupBy;
  String? pickupRemark;
  String? pickupDate;
  dynamic cancelType;
  String? remark;
  String? deliverRemark;
  String? deliverDate;
  String? pickupslotDate;
  String? pickupslotTime;
  dynamic image;

  SellModel({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.totalMrp,
    this.totalDiscount,
    this.totalPrice,
    this.createdDate,
    this.createdDates,
    this.confirmDate,
    this.confirmBy,
    this.confirmRemark,
    this.cancelDate,
    this.cancelBy,
    this.cancelRemark,
    this.shippingAddress,
    this.shippingCity,
    this.shippingState,
    this.shippingLandmark,
    this.shippingName,
    this.shippingMobileNo,
    this.shippingEmailId,
    this.shippingPincode,
    this.totalAmount,
    this.customerName,
    this.mobileNo,
    this.emailId,
    this.pickupBy,
    this.pickupRemark,
    this.pickupDate,
    this.cancelType,
    this.remark,
    this.deliverRemark,
    this.deliverDate,
    this.pickupslotDate,
    this.pickupslotTime,
    this.image,
  });

  SellModel copyWith({
    String? customerId,
    String? orderId,
    String? orderStatus,
    int? totalMrp,
    int? totalDiscount,
    int? totalPrice,
    String? createdDate,
    DateTime? createdDates,
    String? confirmDate,
    int? confirmBy,
    String? confirmRemark,
    String? cancelDate,
    int? cancelBy,
    dynamic cancelRemark,
    String? shippingAddress,
    String? shippingCity,
    String? shippingState,
    String? shippingLandmark,
    String? shippingName,
    String? shippingMobileNo,
    String? shippingEmailId,
    String? shippingPincode,
    int? totalAmount,
    String? customerName,
    String? mobileNo,
    String? emailId,
    dynamic pickupBy,
    String? pickupRemark,
    String? pickupDate,
    dynamic cancelType,
    String? remark,
    String? deliverRemark,
    String? deliverDate,
    String? pickupslotDate,
    String? pickupslotTime,
    dynamic image,
  }) =>
      SellModel(
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
        orderStatus: orderStatus ?? this.orderStatus,
        totalMrp: totalMrp ?? this.totalMrp,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalPrice: totalPrice ?? this.totalPrice,
        createdDate: createdDate ?? this.createdDate,
        createdDates: createdDates ?? this.createdDates,
        confirmDate: confirmDate ?? this.confirmDate,
        confirmBy: confirmBy ?? this.confirmBy,
        confirmRemark: confirmRemark ?? this.confirmRemark,
        cancelDate: cancelDate ?? this.cancelDate,
        cancelBy: cancelBy ?? this.cancelBy,
        cancelRemark: cancelRemark ?? this.cancelRemark,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        shippingCity: shippingCity ?? this.shippingCity,
        shippingState: shippingState ?? this.shippingState,
        shippingLandmark: shippingLandmark ?? this.shippingLandmark,
        shippingName: shippingName ?? this.shippingName,
        shippingMobileNo: shippingMobileNo ?? this.shippingMobileNo,
        shippingEmailId: shippingEmailId ?? this.shippingEmailId,
        shippingPincode: shippingPincode ?? this.shippingPincode,
        totalAmount: totalAmount ?? this.totalAmount,
        customerName: customerName ?? this.customerName,
        mobileNo: mobileNo ?? this.mobileNo,
        emailId: emailId ?? this.emailId,
        pickupBy: pickupBy ?? this.pickupBy,
        pickupRemark: pickupRemark ?? this.pickupRemark,
        pickupDate: pickupDate ?? this.pickupDate,
        cancelType: cancelType ?? this.cancelType,
        remark: remark ?? this.remark,
        deliverRemark: deliverRemark ?? this.deliverRemark,
        deliverDate: deliverDate ?? this.deliverDate,
        pickupslotDate: pickupslotDate ?? this.pickupslotDate,
        pickupslotTime: pickupslotTime ?? this.pickupslotTime,
        image: image ?? this.image,
      );

  factory SellModel.fromJson(Map<String, dynamic> json) => SellModel(
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    orderStatus: json["OrderStatus"],
    totalMrp: json["TotalMRP"],
    totalDiscount: json["TotalDiscount"],
    totalPrice: json["TotalPrice"],
    createdDate: json["CreatedDate"],
    createdDates: json["CreatedDates"] == null ? null : DateTime.parse(json["CreatedDates"]),
    confirmDate: json["ConfirmDate"],
    confirmBy: json["ConfirmBy"],
    confirmRemark: json["ConfirmRemark"],
    cancelDate: json["CancelDate"],
    cancelBy: json["CancelBy"],
    cancelRemark: json["CancelRemark"],
    shippingAddress: json["ShippingAddress"],
    shippingCity: json["ShippingCity"],
    shippingState: json["ShippingState"],
    shippingLandmark: json["ShippingLandmark"],
    shippingName: json["ShippingName"],
    shippingMobileNo: json["ShippingMobileNo"],
    shippingEmailId: json["ShippingEmailId"],
    shippingPincode: json["ShippingPincode"],
    totalAmount: json["TotalAmount"],
    customerName: json["CustomerName"],
    mobileNo: json["MobileNo"],
    emailId: json["EmailId"],
    pickupBy: json["PickupBy"],
    pickupRemark: json["PickupRemark"],
    pickupDate: json["PickupDate"],
    cancelType: json["CancelType"],
    remark: json["Remark"],
    deliverRemark: json["DeliverRemark"],
    deliverDate: json["DeliverDate"],
    pickupslotDate: json["PickupslotDate"],
    pickupslotTime: json["PickupslotTime"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "OrderId": orderId,
    "OrderStatus": orderStatus,
    "TotalMRP": totalMrp,
    "TotalDiscount": totalDiscount,
    "TotalPrice": totalPrice,
    "CreatedDate": createdDate,
    "CreatedDates": createdDates?.toIso8601String(),
    "ConfirmDate": confirmDate,
    "ConfirmBy": confirmBy,
    "ConfirmRemark": confirmRemark,
    "CancelDate": cancelDate,
    "CancelBy": cancelBy,
    "CancelRemark": cancelRemark,
    "ShippingAddress": shippingAddress,
    "ShippingCity": shippingCity,
    "ShippingState": shippingState,
    "ShippingLandmark": shippingLandmark,
    "ShippingName": shippingName,
    "ShippingMobileNo": shippingMobileNo,
    "ShippingEmailId": shippingEmailId,
    "ShippingPincode": shippingPincode,
    "TotalAmount": totalAmount,
    "CustomerName": customerName,
    "MobileNo": mobileNo,
    "EmailId": emailId,
    "PickupBy": pickupBy,
    "PickupRemark": pickupRemark,
    "PickupDate": pickupDate,
    "CancelType": cancelType,
    "Remark": remark,
    "DeliverRemark": deliverRemark,
    "DeliverDate": deliverDate,
    "PickupslotDate": pickupslotDate,
    "PickupslotTime": pickupslotTime,
    "Image": image,
  };
}
