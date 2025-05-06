// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
  String? customerId;
  String? orderId;
  String? orderStatus;
  String? shippingId;
  String? name;
  String? mobileNo;
  String? emailId;
  String? address;
  String? landmark;
  dynamic city;
  dynamic? state;
  String? pincode;
  String? workType;
  String? notes;
  String? couponType;
  String? transactionId;
  String? loginType;
  String? orderOn;
  String? orderType;
  dynamic totalMrp;
  dynamic totalPrice;
  dynamic totalAmount;
  dynamic totalDiscount;
  dynamic deliveryCharge;
  dynamic couponId;
  dynamic couponAmount;
  List<Map<String, int>>? orderProductLists;

  CreateOrderModel({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.shippingId,
    this.name,
    this.mobileNo,
    this.emailId,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.workType,
    this.notes,
    this.couponType,
    this.transactionId,
    this.loginType,
    this.orderOn,
    this.orderType,
    this.totalMrp,
    this.totalPrice,
    this.totalAmount,
    this.totalDiscount,
    this.deliveryCharge,
    this.couponId,
    this.couponAmount,
    this.orderProductLists,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    orderStatus: json["OrderStatus"],
    shippingId: json["ShippingId"],
    name: json["Name"],
    mobileNo: json["MobileNo"],
    emailId: json["EmailId"],
    address: json["Address"],
    landmark: json["Landmark"],
    city: json["City"],
    state: json["State"],
    pincode: json["Pincode"],
    workType: json["WorkType"],
    notes: json["Notes"],
    couponType: json["CouponType"],
    transactionId: json["TransactionId"],
    loginType: json["LoginType"],
    orderOn: json["OrderOn"],
    orderType: json["OrderType"],
    totalMrp: json["TotalMRP"],
    totalPrice: json["TotalPrice"],
    totalAmount: json["TotalAmount"],
    totalDiscount: json["TotalDiscount"],
    deliveryCharge: json["DeliveryCharge"],
    couponId: json["CouponId"],
    couponAmount: json["CouponAmount"],
    orderProductLists: json["OrderProductLists"] == null ? [] : List<Map<String, int>>.from(json["OrderProductLists"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "OrderId": orderId,
    "OrderStatus": orderStatus,
    "ShippingId": shippingId,
    "Name": name,
    "MobileNo": mobileNo,
    "EmailId": emailId,
    "Address": address,
    "Landmark": landmark,
    "City": city,
    "State": state,
    "Pincode": pincode,
    "WorkType": workType,
    "Notes": notes,
    "CouponType": couponType,
    "TransactionId": transactionId,
    "LoginType": loginType,
    "OrderOn": orderOn,
    "OrderType": orderType,
    "TotalMRP": totalMrp,
    "TotalPrice": totalPrice,
    "TotalAmount": totalAmount,
    "TotalDiscount": totalDiscount,
    "DeliveryCharge": deliveryCharge,
    "CouponId": couponId,
    "CouponAmount": couponAmount,
    "OrderProductLists": orderProductLists == null ? [] : List<dynamic>.from(orderProductLists!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
