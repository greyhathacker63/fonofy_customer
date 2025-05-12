// To parse this JSON data, do
//
//     final orderDetailsForPayModel = orderDetailsForPayModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsForPayModel orderDetailsForPayModelFromJson(String str) => OrderDetailsForPayModel.fromJson(json.decode(str));

String orderDetailsForPayModelToJson(OrderDetailsForPayModel data) => json.encode(data.toJson());

class OrderDetailsForPayModel {
  dynamic id;
  String? customerId;
  String? orderId;
  String? orderStatus;
  String? paymentStatus;
  dynamic totalMrp;
  dynamic totalDiscount;
  dynamic totalPrice;
  dynamic deliveryCharge;
  DateTime? createdDate;
  dynamic updatedDate;
  bool? status;
  bool? isdeleted;
  dynamic confirmDate;
  dynamic confirmBy;
  dynamic confirmRemark;
  dynamic dispatchDate;
  dynamic dispatchBy;
  dynamic dispatchRemark;
  dynamic deliverDate;
  dynamic deliverBy;
  dynamic deliverRemark;
  dynamic cancelDate;
  dynamic cancelBy;
  dynamic cancelRemark;
  dynamic cancelType;
  String? remark;
  dynamic couponId;
  String? shippingId;
  String? shippingName;
  String? shippingMobileNo;
  String? shippingEmailId;
  String? shippingAddress;
  String? shippingLandmark;
  String? shippingCity;
  String? shippingState;
  String? shippingPincode;
  String? orderOn;
  dynamic totalAmount;
  dynamic couponAmount;
  dynamic couponName;
  dynamic couponDiscountType;
  dynamic invoiceNumber;
  dynamic invoiceDate;
  dynamic isInvoice;
  dynamic returnInitiatedRemark;
  dynamic returnInitiatedDate;
  dynamic returnInitiatedBy;
  dynamic returnBy;
  dynamic returnDate;
  dynamic returnRemark;
  dynamic couponCode;
  dynamic couponPercent;
  String? workType;
  String? transactionId;
  String? paymentId;
  dynamic wayBill;
  dynamic requestForPickup;
  dynamic requestForPickupCreatedDate;
  dynamic requestForPickupCreatedBy;
  dynamic requestForPickupTime;
  dynamic requestForPickupDate;
  dynamic requestForPickupRemark;
  dynamic pickupId;
  dynamic totalWeight;
  String? orderType;
  dynamic paymentAmount;

  OrderDetailsForPayModel({
    this.id,
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.paymentStatus,
    this.totalMrp,
    this.totalDiscount,
    this.totalPrice,
    this.deliveryCharge,
    this.createdDate,
    this.updatedDate,
    this.status,
    this.isdeleted,
    this.confirmDate,
    this.confirmBy,
    this.confirmRemark,
    this.dispatchDate,
    this.dispatchBy,
    this.dispatchRemark,
    this.deliverDate,
    this.deliverBy,
    this.deliverRemark,
    this.cancelDate,
    this.cancelBy,
    this.cancelRemark,
    this.cancelType,
    this.remark,
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
    this.orderOn,
    this.totalAmount,
    this.couponAmount,
    this.couponName,
    this.couponDiscountType,
    this.invoiceNumber,
    this.invoiceDate,
    this.isInvoice,
    this.returnInitiatedRemark,
    this.returnInitiatedDate,
    this.returnInitiatedBy,
    this.returnBy,
    this.returnDate,
    this.returnRemark,
    this.couponCode,
    this.couponPercent,
    this.workType,
    this.transactionId,
    this.paymentId,
    this.wayBill,
    this.requestForPickup,
    this.requestForPickupCreatedDate,
    this.requestForPickupCreatedBy,
    this.requestForPickupTime,
    this.requestForPickupDate,
    this.requestForPickupRemark,
    this.pickupId,
    this.totalWeight,
    this.orderType,
    this.paymentAmount,
  });

  factory OrderDetailsForPayModel.fromJson(Map<String, dynamic> json) => OrderDetailsForPayModel(
    id: json["Id"],
    customerId: json["CustomerId"],
    orderId: json["OrderId"],
    orderStatus: json["OrderStatus"],
    paymentStatus: json["PaymentStatus"],
    totalMrp: json["TotalMRP"],
    totalDiscount: json["TotalDiscount"],
    totalPrice: json["TotalPrice"],
    deliveryCharge: json["DeliveryCharge"],
    createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
    updatedDate: json["UpdatedDate"],
    status: json["Status"],
    isdeleted: json["Isdeleted"],
    confirmDate: json["ConfirmDate"],
    confirmBy: json["ConfirmBy"],
    confirmRemark: json["ConfirmRemark"],
    dispatchDate: json["DispatchDate"],
    dispatchBy: json["DispatchBy"],
    dispatchRemark: json["DispatchRemark"],
    deliverDate: json["DeliverDate"],
    deliverBy: json["DeliverBy"],
    deliverRemark: json["DeliverRemark"],
    cancelDate: json["CancelDate"],
    cancelBy: json["CancelBy"],
    cancelRemark: json["CancelRemark"],
    cancelType: json["CancelType"],
    remark: json["Remark"],
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
    orderOn: json["OrderOn"],
    totalAmount: json["TotalAmount"],
    couponAmount: json["CouponAmount"],
    couponName: json["CouponName"],
    couponDiscountType: json["CouponDiscountType"],
    invoiceNumber: json["InvoiceNumber"],
    invoiceDate: json["InvoiceDate"],
    isInvoice: json["IsInvoice"],
    returnInitiatedRemark: json["ReturnInitiatedRemark"],
    returnInitiatedDate: json["ReturnInitiatedDate"],
    returnInitiatedBy: json["ReturnInitiatedBy"],
    returnBy: json["ReturnBy"],
    returnDate: json["ReturnDate"],
    returnRemark: json["ReturnRemark"],
    couponCode: json["CouponCode"],
    couponPercent: json["CouponPercent"],
    workType: json["WorkType"],
    transactionId: json["TransactionId"],
    paymentId: json["PaymentId"],
    wayBill: json["WayBill"],
    requestForPickup: json["RequestForPickup"],
    requestForPickupCreatedDate: json["RequestForPickupCreatedDate"],
    requestForPickupCreatedBy: json["RequestForPickupCreatedBy"],
    requestForPickupTime: json["RequestForPickupTime"],
    requestForPickupDate: json["RequestForPickupDate"],
    requestForPickupRemark: json["RequestForPickupRemark"],
    pickupId: json["PickupId"],
    totalWeight: json["TotalWeight"],
    orderType: json["OrderType"],
    paymentAmount: json["PaymentAmount"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "CustomerId": customerId,
    "OrderId": orderId,
    "OrderStatus": orderStatus,
    "PaymentStatus": paymentStatus,
    "TotalMRP": totalMrp,
    "TotalDiscount": totalDiscount,
    "TotalPrice": totalPrice,
    "DeliveryCharge": deliveryCharge,
    "CreatedDate": createdDate?.toIso8601String(),
    "UpdatedDate": updatedDate,
    "Status": status,
    "Isdeleted": isdeleted,
    "ConfirmDate": confirmDate,
    "ConfirmBy": confirmBy,
    "ConfirmRemark": confirmRemark,
    "DispatchDate": dispatchDate,
    "DispatchBy": dispatchBy,
    "DispatchRemark": dispatchRemark,
    "DeliverDate": deliverDate,
    "DeliverBy": deliverBy,
    "DeliverRemark": deliverRemark,
    "CancelDate": cancelDate,
    "CancelBy": cancelBy,
    "CancelRemark": cancelRemark,
    "CancelType": cancelType,
    "Remark": remark,
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
    "OrderOn": orderOn,
    "TotalAmount": totalAmount,
    "CouponAmount": couponAmount,
    "CouponName": couponName,
    "CouponDiscountType": couponDiscountType,
    "InvoiceNumber": invoiceNumber,
    "InvoiceDate": invoiceDate,
    "IsInvoice": isInvoice,
    "ReturnInitiatedRemark": returnInitiatedRemark,
    "ReturnInitiatedDate": returnInitiatedDate,
    "ReturnInitiatedBy": returnInitiatedBy,
    "ReturnBy": returnBy,
    "ReturnDate": returnDate,
    "ReturnRemark": returnRemark,
    "CouponCode": couponCode,
    "CouponPercent": couponPercent,
    "WorkType": workType,
    "TransactionId": transactionId,
    "PaymentId": paymentId,
    "WayBill": wayBill,
    "RequestForPickup": requestForPickup,
    "RequestForPickupCreatedDate": requestForPickupCreatedDate,
    "RequestForPickupCreatedBy": requestForPickupCreatedBy,
    "RequestForPickupTime": requestForPickupTime,
    "RequestForPickupDate": requestForPickupDate,
    "RequestForPickupRemark": requestForPickupRemark,
    "PickupId": pickupId,
    "TotalWeight": totalWeight,
    "OrderType": orderType,
    "PaymentAmount": paymentAmount,
  };
}
