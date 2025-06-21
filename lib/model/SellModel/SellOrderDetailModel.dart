class SellOrderDetailProduct {
  final String? phoneNumber;
  final String? pickupslotDate;
  final String? pickupslotTime;
  final String? orderId;
  final String? shippingName;
  final String? shippingMobileNo;
  final String? shippingEmailId;
  final String? shippingAddress;
  final String? shippingLandmark;
  final String? shippingCity;
  final String? shippingState;
  final String? shippingPincode;
  final String? shippingId;
  final String? image;
  final String? productAndModelName;
  final String? colorName;
  final dynamic totalAmount;
  final dynamic totalDiscount;
  final dynamic totalMRP;
  final dynamic totalPrice;

  SellOrderDetailProduct({
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
    this.totalMRP,
    this.totalPrice,
  });

  factory SellOrderDetailProduct.fromJson(Map<String, dynamic> json) {
    return SellOrderDetailProduct(
      phoneNumber: json['PhoneNumber'],
      pickupslotDate: json['PickupslotDate'],
      pickupslotTime: json['PickupslotTime'],
      orderId: json['OrderId'],
      shippingName: json['ShippingName'],
      shippingMobileNo: json['ShippingMobileNo'],
      shippingEmailId: json['ShippingEmailId'],
      shippingAddress: json['ShippingAddress'],
      shippingLandmark: json['ShippingLandmark'],
      shippingCity: json['ShippingCity'],
      shippingState: json['ShippingState'],
      shippingPincode: json['ShippingPincode'],
      shippingId: json['ShippingId'],
      image: json['Image'],
      productAndModelName: json['ProductAndModelName'],
      colorName: json['ColorName'],
      totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
      totalDiscount: (json['TotalDiscount'] as num?)?.toDouble(),
      totalMRP: (json['TotalMRP'] as num?)?.toDouble(),
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
    );
  }
}

class SellOrderDetailInfo {
  final String? customerId;
  final String? orderId;
  final String? orderStatus;
  final String? pickupslotTime;

  SellOrderDetailInfo({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.pickupslotTime,
  });

  factory SellOrderDetailInfo.fromJson(Map<String, dynamic> json) {
    return SellOrderDetailInfo(
      customerId: json['CustomerId'],
      orderId: json['OrderId'],
      orderStatus: json['OrderStatus'],
      pickupslotTime: json['PickupslotTime'],
    );
  }
}
