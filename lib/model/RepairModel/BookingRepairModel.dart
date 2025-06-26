import 'dart:ffi';

import 'package:fonofy/model/RepairModel/RepairServicesTableModel.dart';

class RepairBookingRequestModel {
  dynamic modelId;
  dynamic romId;
  dynamic ramId;
  dynamic colorId;
  String customerId;
  String orderId;
  double servieCharge;
  dynamic couponId;
  String shippingId;
  String shippingName;
  String shippingMobileNo;
  String shippingEmailId;
  String shippingAddress;
  String shippingLandmark;
  String shippingCity;
  String shippingState;
  String shippingPincode;
  String workType;
  String couponName;
  String couponDiscountType;
  dynamic couponAmount;
  dynamic couponPercent;
  String couponCode;
  String repairType;
  String slotDate;
  String remark;
  dynamic deliveryCharge;
  dynamic totalAmount;
  double totalPrice;
  double totalDiscount;
  dynamic totalMRP;
  String Mode;
  List<RepairDetail> repairDetails;

  RepairBookingRequestModel({
    required this.modelId,
    required this.romId,
    required this.ramId,
    required this.colorId,
    required this.customerId,
    required this.orderId,
    required this.servieCharge,
    this.couponId,
    required this.shippingId,
    required this.shippingName,
    required this.shippingMobileNo,
    required this.shippingEmailId,
    required this.shippingAddress,
    required this.shippingLandmark,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPincode,
    required this.workType,
    required this.couponName,
    required this.couponDiscountType,
    required this.couponAmount,
    required this.couponPercent,
    required this.couponCode,
    required this.repairType,
    required this.slotDate,
    required this.remark,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.totalPrice,
    required this.totalDiscount,
    required this.totalMRP,
    required this.Mode,
    required this.repairDetails,
  });

  factory RepairBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      RepairBookingRequestModel(
        modelId: json["ModelId"],
        romId: json["ROMId"],
        ramId: json["RAMId"],
        colorId: json["ColorId"],
        customerId: json["CustomerId"],
        orderId: json["OrderId"],
        servieCharge: (json["ServieCharge"] ?? 0).toDouble(),
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
        couponAmount: (json["CouponAmount"] ?? 0).toDouble(),
        couponPercent: (json["CouponPercent"] ?? 0).toDouble(),
        couponCode: json["CouponCode"],
        repairType: json["RepairType"],
        slotDate: json["SlotDate"],
        remark: json["Remark"],
        deliveryCharge: (json["DeliveryCharge"] ?? 0).toDouble(),
        totalAmount: (json["TotalAmount"] ?? 0).toDouble(),
        totalPrice: (json["TotalPrice"] ?? 0).toDouble(),
        totalDiscount: (json["TotalDiscount"] ?? 0).toDouble(),
        totalMRP: (json["TotalMRP"] ?? 0).toDouble(),
        Mode: json["Mode"],
        repairDetails: List<RepairDetail>.from(
          json["RepairDetails"].map((x) => RepairDetail.fromJson(x)),
        ),
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
        "TotalMRP": totalMRP,
        "Mode": Mode,
        "RepairDetails": repairDetails.map((e) => e.toJson()).toList(),
      };
}

class RepairDetail {
  String customerId;
  String orderId;
  dynamic serviceId;
  String serviceName;
  dynamic serviceAmount;
  dynamic serviceDiscount;
  dynamic servicePercent;

  RepairDetail({
    required this.customerId,
    required this.orderId,
    required this.serviceId,
    required this.serviceName,
    required this.serviceAmount,
    required this.serviceDiscount,
    required this.servicePercent,
  });

  factory RepairDetail.fromJson(Map<String, dynamic> json) => RepairDetail(
        customerId: json["CustomerId"],
        orderId: json["OrderId"],
        serviceId: json["ServiceId"],
        serviceName: json["ServiceName"],
        serviceAmount: (json["ServiceAmount"] ?? 0).toDouble(),
        serviceDiscount: (json["ServiceDiscount"] ?? 0).toDouble(),
        servicePercent: (json["ServicePercent"] ?? 0).toDouble(),
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
