class SellModel {
  final String? customerId;
  final String? orderId;
  final String? orderStatus;
  final dynamic totalMRP;
  final dynamic totalDiscount;
  final dynamic totalPrice;
  final String? createdDate;
  final DateTime? createdDates;
  final String? confirmDate;
  final String? confirmBy;
  final String? confirmRemark;
  final String? cancelDate;
  final dynamic cancelBy;
  final String? cancelRemark;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingState;
  final String? shippingLandmark;
  final String? shippingName;
  final String? shippingMobileNo;
  final String? shippingEmailId;
  final String? shippingPincode;
  final dynamic totalAmount;
  final String? customerName;
  final String? mobileNo;
  final String? emailId;
  final String? pickupBy;
  final String? pickupRemark;
  final String? pickupDate;
  final String? cancelType;
  final String? remark;
  final String? deliverRemark;
  final String? deliverDate;
  final String? pickupslotDate;
  final String? pickupslotTime;
  final String? image;

  SellModel({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.totalMRP,
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

  factory SellModel.fromJson(Map<String, dynamic> json) {
    return SellModel(
      customerId: json['CustomerId'],
      orderId: json['OrderId'],
      orderStatus: json['OrderStatus'],
      totalMRP: (json['TotalMRP'] as num?)?.toDouble(),
      totalDiscount: (json['TotalDiscount'] as num?)?.toDouble(),
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
      createdDate: json['CreatedDate'],
      createdDates: json['CreatedDates'] != null ? DateTime.tryParse(json['CreatedDates']) : null,
      confirmDate: json['ConfirmDate'],
      confirmBy: json['ConfirmBy'],
      confirmRemark: json['ConfirmRemark'],
      cancelDate: json['CancelDate'],
      cancelBy: json['CancelBy'],
      cancelRemark: json['CancelRemark'],
      shippingAddress: json['ShippingAddress'],
      shippingCity: json['ShippingCity'],
      shippingState: json['ShippingState'],
      shippingLandmark: json['ShippingLandmark'],
      shippingName: json['ShippingName'],
      shippingMobileNo: json['ShippingMobileNo'],
      shippingEmailId: json['ShippingEmailId'],
      shippingPincode: json['ShippingPincode'],
      totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
      customerName: json['CustomerName'],
      mobileNo: json['MobileNo'],
      emailId: json['EmailId'],
      pickupBy: json['PickupBy'],
      pickupRemark: json['PickupRemark'],
      pickupDate: json['PickupDate'],
      cancelType: json['CancelType'],
      remark: json['Remark'],
      deliverRemark: json['DeliverRemark'],
      deliverDate: json['DeliverDate'],
      pickupslotDate: json['PickupslotDate'],
      pickupslotTime: json['PickupslotTime'],
      image: json['Image'],
    );
  }
}
