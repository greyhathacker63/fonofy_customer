class RepairBookingRequest {
  final dynamic modelId;
  final dynamic romId;
  final dynamic ramId;
  final dynamic colorId;
  final String customerId;
  final String orderId;
  final dynamic servieCharge;
  final dynamic couponId;
  final String shippingId;
  final String shippingName;
  final String shippingMobileNo;
  final String shippingEmailId;
  final String shippingAddress;
  final String shippingLandmark;
  final dynamic shippingCity;
  final dynamic shippingState;
  final String shippingPincode;
  final String workType;
  final String couponName;
  final String couponDiscountType;
  final dynamic couponAmount;
  final dynamic couponPercent;
  final String couponCode;
  final String repairType;
  final String slotDate;
  final String remark;
  final dynamic deliveryCharge;
  final dynamic totalAmount;
  final dynamic totalPrice;
  final dynamic totalDiscount;
  final dynamic totalMRP;
  final String mode;
  final List<RepairDetail> repairDetails;

  RepairBookingRequest({
    required this.modelId,
    required this.romId,
    required this.ramId,
    required this.colorId,
    required this.customerId,
    required this.orderId,
    required this.servieCharge,
    required this.couponId,
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
    required this.mode,
    required this.repairDetails,
  });

  Map<String, dynamic> toJson() {
    return {
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
      "Mode": mode,
      "RepairDetails": repairDetails.map((e) => e.toJson()).toList(),
    };
  }
}

class RepairDetail {
  final String customerId;
  final String orderId;
  final dynamic serviceId;
  final String serviceName;
  final dynamic serviceAmount;
  final dynamic serviceDiscount;
  final dynamic servicePercent;

  RepairDetail({
    required this.customerId,
    required this.orderId,
    required this.serviceId,
    required this.serviceName,
    required this.serviceAmount,
    required this.serviceDiscount,
    required this.servicePercent,
  });

  Map<String, dynamic> toJson() {
    return {
      "CustomerId": customerId,
      "OrderId": orderId,
      "ServiceId": serviceId,
      "ServiceName": serviceName,
      "ServiceAmount": serviceAmount,
      "ServiceDiscount": serviceDiscount,
      "ServicePercent": servicePercent,
    };
  }
}
