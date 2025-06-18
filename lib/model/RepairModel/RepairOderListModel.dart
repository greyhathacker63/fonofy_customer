// To parse this JSON data, do
//
//     final repairOderListModel = repairOderListModelFromJson(jsonString);

import 'dart:convert';

List<RepairOderListModel> repairOderListModelFromJson(String str) => List<RepairOderListModel>.from(json.decode(str).map((x) => RepairOderListModel.fromJson(x)));

String repairOderListModelToJson(List<RepairOderListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairOderListModel {
  String? customerId;
  String? orderId;
  String? orderStatus;
  dynamic totalMrp;
  dynamic totalDiscount;
  dynamic deliveryCharge;
  dynamic totalPrice;
  String? createdDate;
  DateTime? createdDates;
  dynamic confirmDate;
  dynamic confirmBy;
  dynamic confirmRemark;
  dynamic cancelDate;
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
  String? repairType;
  dynamic totalAmount;
  dynamic couponAmount;
  String? couponName;
  String? couponDiscountType;
  String? customerName;
  String? mobileNo;
  String? emailId;
  String? couponCode;
  dynamic couponPercent;
  dynamic cancelType;
  String? remark;
  dynamic couponId;
  dynamic deliverRemark;
  dynamic deliverDate;
  dynamic image;

  RepairOderListModel({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.totalMrp,
    this.totalDiscount,
    this.deliveryCharge,
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
    this.repairType,
    this.totalAmount,
    this.couponAmount,
    this.couponName,
    this.couponDiscountType,
    this.customerName,
    this.mobileNo,
    this.emailId,
    this.couponCode,
    this.couponPercent,
    this.cancelType,
    this.remark,
    this.couponId,
    this.deliverRemark,
    this.deliverDate,
    this.image,
  });

  RepairOderListModel copyWith({
    String? customerId,
    String? orderId,
    String? orderStatus,
    int? totalMrp,
    int? totalDiscount,
    int? deliveryCharge,
    int? totalPrice,
    String? createdDate,
    DateTime? createdDates,
    dynamic confirmDate,
    dynamic confirmBy,
    dynamic confirmRemark,
    dynamic cancelDate,
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
    String? repairType,
    int? totalAmount,
    int? couponAmount,
    String? couponName,
    String? couponDiscountType,
    String? customerName,
    String? mobileNo,
    String? emailId,
    String? couponCode,
    int? couponPercent,
    dynamic cancelType,
    String? remark,
    int? couponId,
    dynamic deliverRemark,
    dynamic deliverDate,
    dynamic image,
  }) =>
      RepairOderListModel(
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
        orderStatus: orderStatus ?? this.orderStatus,
        totalMrp: totalMrp ?? this.totalMrp,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
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
        repairType: repairType ?? this.repairType,
        totalAmount: totalAmount ?? this.totalAmount,
        couponAmount: couponAmount ?? this.couponAmount,
        couponName: couponName ?? this.couponName,
        couponDiscountType: couponDiscountType ?? this.couponDiscountType,
        customerName: customerName ?? this.customerName,
        mobileNo: mobileNo ?? this.mobileNo,
        emailId: emailId ?? this.emailId,
        couponCode: couponCode ?? this.couponCode,
        couponPercent: couponPercent ?? this.couponPercent,
        cancelType: cancelType ?? this.cancelType,
        remark: remark ?? this.remark,
        couponId: couponId ?? this.couponId,
        deliverRemark: deliverRemark ?? this.deliverRemark,
        deliverDate: deliverDate ?? this.deliverDate,
        image: image ?? this.image,
      );

  factory RepairOderListModel.fromJson(Map<String, dynamic> json) => RepairOderListModel(
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    orderStatus: json["OrderStatus"],
    totalMrp: json["TotalMRP"],
    totalDiscount: json["TotalDiscount"],
    deliveryCharge: json["DeliveryCharge"],
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
    repairType: json["RepairType"],
    totalAmount: json["TotalAmount"],
    couponAmount: json["CouponAmount"],
    couponName: json["CouponName"],
    couponDiscountType: json["CouponDiscountType"],
    customerName: json["CustomerName"],
    mobileNo: json["MobileNo"],
    emailId: json["EmailId"],
    couponCode: json["CouponCode"],
    couponPercent: json["CouponPercent"],
    cancelType: json["CancelType"],
    remark: json["Remark"],
    couponId: json["CouponId"],
    deliverRemark: json["DeliverRemark"],
    deliverDate: json["DeliverDate"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "OrderId": orderId,
    "OrderStatus": orderStatus,
    "TotalMRP": totalMrp,
    "TotalDiscount": totalDiscount,
    "DeliveryCharge": deliveryCharge,
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
    "RepairType": repairType,
    "TotalAmount": totalAmount,
    "CouponAmount": couponAmount,
    "CouponName": couponName,
    "CouponDiscountType": couponDiscountType,
    "CustomerName": customerName,
    "MobileNo": mobileNo,
    "EmailId": emailId,
    "CouponCode": couponCode,
    "CouponPercent": couponPercent,
    "CancelType": cancelType,
    "Remark": remark,
    "CouponId": couponId,
    "DeliverRemark": deliverRemark,
    "DeliverDate": deliverDate,
    "Image": image,
  };
}
