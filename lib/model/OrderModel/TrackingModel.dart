import 'dart:convert';

List<TrackingModel> trackingModelFromJson(String str) =>
    List<TrackingModel>.from(json.decode(str).map((x) => TrackingModel.fromJson(x)));

String trackingModelToJson(List<TrackingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

int? parseToInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class TrackingModel {
  String? customerId;
  String? orderId;
  String? orderStatus;
  int? totalMrp;
  int? totalDiscount;
  int? totalPrice;
  int? deliveryCharge;
  DateTime? createdDate;
  String? confirmDate;
  String? confirmBy;
  String? confirmRemark;
  String? dispatchDate;
  String? dispatchBy;
  String? dispatchRemark;
  String? deliverDate;
  String? deliverBy;
  String? deliverRemark;
  String? cancelDate;
  String? cancelBy;
  String? cancelRemark;
  String? cancelType;
  String? remark;
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
  int? totalAmount;
  int? couponAmount;
  String? couponName;
  String? couponDiscountType;
  String? invoiceNumber;
  String? invoiceDate;
  bool? isInvoice;
  String? returnInitiatedRemark;
  String? returnInitiatedDate;
  String? returnInitiatedBy;
  String? returnBy;
  String? returnDate;
  String? returnRemark;
  String? couponCode;
  int? couponPercent;
  String? workType;
  String? transactionId;
  String? paymentId;
  String? wayBill;
  String? requestForPickup;
  String? requestForPickupCreatedDate;
  String? requestForPickupCreatedBy;
  String? requestForPickupTime;
  String? requestForPickupDate;
  String? requestForPickupRemark;
  String? pickupId;
  String? orderType;
  int? paymentAmount;
  String? productImage;

  TrackingModel({
    this.customerId,
    this.orderId,
    this.orderStatus,
    this.totalMrp,
    this.totalDiscount,
    this.totalPrice,
    this.deliveryCharge,
    this.createdDate,
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
    this.orderType,
    this.paymentAmount,
    this.productImage,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
        customerId: json["CustomerId"],
        orderId: json["OrderId"],
        orderStatus: json["OrderStatus"],
        totalMrp: parseToInt(json["TotalMRP"]),
        totalDiscount: parseToInt(json["TotalDiscount"]),
        totalPrice: parseToInt(json["TotalPrice"]),
        deliveryCharge: parseToInt(json["DeliveryCharge"]),
        createdDate: json["CreatedDate"] == null
            ? null
            : DateTime.tryParse(json["CreatedDate"]),
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
        totalAmount: parseToInt(json["TotalAmount"]),
        couponAmount: parseToInt(json["CouponAmount"]),
        couponName: json["CouponName"],
        couponDiscountType: json["CouponDiscountType"],
        invoiceNumber: json["InvoiceNumber"],
        invoiceDate: json["InvoiceDate"],
        isInvoice: json["IsInvoice"] == true,
        returnInitiatedRemark: json["ReturnInitiatedRemark"],
        returnInitiatedDate: json["ReturnInitiatedDate"],
        returnInitiatedBy: json["ReturnInitiatedBy"],
        returnBy: json["ReturnBy"],
        returnDate: json["ReturnDate"],
        returnRemark: json["ReturnRemark"],
        couponCode: json["CouponCode"],
        couponPercent: parseToInt(json["CouponPercent"]),
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
        orderType: json["OrderType"],
        paymentAmount: parseToInt(json["PaymentAmount"]),
        productImage: json["ProductImage"],
      );

  Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "OrderId": orderId,
        "OrderStatus": orderStatus,
        "TotalMRP": totalMrp,
        "TotalDiscount": totalDiscount,
        "TotalPrice": totalPrice,
        "DeliveryCharge": deliveryCharge,
        "CreatedDate": createdDate?.toIso8601String(),
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
        "OrderType": orderType,
        "PaymentAmount": paymentAmount,
        "ProductImage": productImage,
      };
}
