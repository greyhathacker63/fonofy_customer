// To parse this JSON data, do
//
//     final repairBookingModel = repairBookingModelFromJson(jsonString);

import 'dart:convert';

RepairBookingModel repairBookingModelFromJson(String str) => RepairBookingModel.fromJson(json.decode(str));

String repairBookingModelToJson(RepairBookingModel data) => json.encode(data.toJson());

class RepairBookingModel {
  dynamic modelId;
  dynamic romId;
  dynamic ramId;
  dynamic colorId;
  String? customerId;
  String? orderId;
  dynamic servieCharge;
  dynamic couponId;
  String? shippingId;
  String? shippingName;
  String? shippingMobileNo;
  String? shippingEmailId;
  String? shippingAddress;
  String? shippingLandmark;
  dynamic shippingCity;
  dynamic shippingState;
  String? shippingPincode;
  String? workType;
  String? couponName;
  String? couponDiscountType;
  dynamic couponAmount;
  dynamic couponPercent;
  String? couponCode;
  String? repairType;
  String? slotDate;
  String? remark;
  dynamic deliveryCharge;
  dynamic totalAmount;
  dynamic totalPrice;
  dynamic totalDiscount;
  dynamic totalMrp;
  String? mode;
  List<RepairDetail>? repairDetails;

  RepairBookingModel({
    this.modelId,
    this.romId,
    this.ramId,
    this.colorId,
    this.customerId,
    this.orderId,
    this.servieCharge,
    this.couponId,
    this.shippingId,
    this.shippingName,
    this.shippingMobileNo,
    this.shippingEmailId,
    this.shippingAddress,
    this.shippingLandmark,
    this.shippingCity,
    this.shippingState,
    this.shippingPincode,
    this.workType,
    this.couponName,
    this.couponDiscountType,
    this.couponAmount,
    this.couponPercent,
    this.couponCode,
    this.repairType,
    this.slotDate,
    this.remark,
    this.deliveryCharge,
    this.totalAmount,
    this.totalPrice,
    this.totalDiscount,
    this.totalMrp,
    this.mode,
    this.repairDetails,
  });

  RepairBookingModel copyWith({
    dynamic modelId,
    dynamic romId,
    dynamic ramId,
    dynamic colorId,
    String? customerId,
    String? orderId,
    dynamic servieCharge,
    dynamic couponId,
    String? shippingId,
    String? shippingName,
    String? shippingMobileNo,
    String? shippingEmailId,
    String? shippingAddress,
    String? shippingLandmark,
    dynamic shippingCity,
    dynamic shippingState,
    String? shippingPincode,
    String? workType,
    String? couponName,
    String? couponDiscountType,
    dynamic couponAmount,
    dynamic couponPercent,
    String? couponCode,
    String? repairType,
    String? slotDate,
    String? remark,
    dynamic deliveryCharge,
    dynamic totalAmount,
    dynamic totalPrice,
    dynamic totalDiscount,
    dynamic totalMrp,
    String? mode,
    List<RepairDetail>? repairDetails,
  }) =>
      RepairBookingModel(
        modelId: modelId ?? this.modelId,
        romId: romId ?? this.romId,
        ramId: ramId ?? this.ramId,
        colorId: colorId ?? this.colorId,
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
        servieCharge: servieCharge ?? this.servieCharge,
        couponId: couponId ?? this.couponId,
        shippingId: shippingId ?? this.shippingId,
        shippingName: shippingName ?? this.shippingName,
        shippingMobileNo: shippingMobileNo ?? this.shippingMobileNo,
        shippingEmailId: shippingEmailId ?? this.shippingEmailId,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        shippingLandmark: shippingLandmark ?? this.shippingLandmark,
        shippingCity: shippingCity ?? this.shippingCity,
        shippingState: shippingState ?? this.shippingState,
        shippingPincode: shippingPincode ?? this.shippingPincode,
        workType: workType ?? this.workType,
        couponName: couponName ?? this.couponName,
        couponDiscountType: couponDiscountType ?? this.couponDiscountType,
        couponAmount: couponAmount ?? this.couponAmount,
        couponPercent: couponPercent ?? this.couponPercent,
        couponCode: couponCode ?? this.couponCode,
        repairType: repairType ?? this.repairType,
        slotDate: slotDate ?? this.slotDate,
        remark: remark ?? this.remark,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        totalAmount: totalAmount ?? this.totalAmount,
        totalPrice: totalPrice ?? this.totalPrice,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalMrp: totalMrp ?? this.totalMrp,
        mode: mode ?? this.mode,
        repairDetails: repairDetails ?? this.repairDetails,
      );

  factory RepairBookingModel.fromJson(Map<String, dynamic> json) => RepairBookingModel(
    modelId: json["ModelId"],
    romId: json["ROMId"],
    ramId: json["RAMId"],
    colorId: json["ColorId"],
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    servieCharge: json["ServieCharge"],
    couponId: json["CouponId"],
    shippingId: json["ShippingId"],
    shippingName: json["ShippingName"],
    shippingMobileNo: json["ShippingMobileNo"],
    shippingEmailId: json["ShippingEmailId"],
    shippingAddress: json["ShippingAddress"],
    shippingLandmark: json["ShippingLandmark"],
    shippingCity: json["ShippingCity"],
    shippingState: json["ShippingState"],
    shippingPincode: json["ShippingPincode"],
    workType: json["WorkType"],
    couponName: json["CouponName"],
    couponDiscountType: json["CouponDiscountType"],
    couponAmount: json["CouponAmount"],
    couponPercent: json["CouponPercent"],
    couponCode: json["CouponCode"],
    repairType: json["RepairType"],
    slotDate: json["SlotDate"],
    remark: json["Remark"],
    deliveryCharge: json["DeliveryCharge"],
    totalAmount: json["TotalAmount"],
    totalPrice: json["TotalPrice"],
    totalDiscount: json["TotalDiscount"],
    totalMrp: json["TotalMRP"],
    mode: json["Mode"],
    repairDetails: json["RepairDetails"] == null ? [] : List<RepairDetail>.from(json["RepairDetails"]!.map((x) => RepairDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ModelId": modelId,
    "ROMId": romId,
    "RAMId": ramId,
    "ColorId": colorId,
    "CustomerId": customerId,
    "OrderId": orderId,
    "ServieCharge": servieCharge,
    "CouponId": couponId,
    "ShippingId": shippingId,
    "ShippingName": shippingName,
    "ShippingMobileNo": shippingMobileNo,
    "ShippingEmailId": shippingEmailId,
    "ShippingAddress": shippingAddress,
    "ShippingLandmark": shippingLandmark,
    "ShippingCity": shippingCity,
    "ShippingState": shippingState,
    "ShippingPincode": shippingPincode,
    "WorkType": workType,
    "CouponName": couponName,
    "CouponDiscountType": couponDiscountType,
    "CouponAmount": couponAmount,
    "CouponPercent": couponPercent,
    "CouponCode": couponCode,
    "RepairType": repairType,
    "SlotDate": slotDate,
    "Remark": remark,
    "DeliveryCharge": deliveryCharge,
    "TotalAmount": totalAmount,
    "TotalPrice": totalPrice,
    "TotalDiscount": totalDiscount,
    "TotalMRP": totalMrp,
    "Mode": mode,
    "RepairDetails": repairDetails == null ? [] : List<dynamic>.from(repairDetails!.map((x) => x.toJson())),
  };
}

class RepairDetail {
  String? customerId;
  String? orderId;
  dynamic serviceId;
  String? serviceName;
  dynamic serviceAmount;
  dynamic serviceDiscount;
  dynamic servicePercent;

  RepairDetail({
    this.customerId,
    this.orderId,
    this.serviceId,
    this.serviceName,
    this.serviceAmount,
    this.serviceDiscount,
    this.servicePercent,
  });

  RepairDetail copyWith({
    String? customerId,
    String? orderId,
    dynamic serviceId,
    String? serviceName,
    dynamic serviceAmount,
    dynamic serviceDiscount,
    dynamic servicePercent,
  }) =>
      RepairDetail(
        customerId: customerId ?? this.customerId,
        orderId: orderId ?? this.orderId,
        serviceId: serviceId ?? this.serviceId,
        serviceName: serviceName ?? this.serviceName,
        serviceAmount: serviceAmount ?? this.serviceAmount,
        serviceDiscount: serviceDiscount ?? this.serviceDiscount,
        servicePercent: servicePercent ?? this.servicePercent,
      );

  factory RepairDetail.fromJson(Map<String, dynamic> json) => RepairDetail(
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    serviceId: json["ServiceId"],
    serviceName: json["ServiceName"],
    serviceAmount: json["ServiceAmount"],
    serviceDiscount: json["ServiceDiscount"],
    servicePercent: json["ServicePercent"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "OrderId": orderId,
    "ServiceId": serviceId,
    "ServiceName": serviceName,
    "ServiceAmount": serviceAmount,
    "ServiceDiscount": serviceDiscount,
    "ServicePercent": servicePercent,
  };
}
