// To parse this JSON data, do
//
//     final shippingChargeModel = shippingChargeModelFromJson(jsonString);

import 'dart:convert';

ShippingChargeModel shippingChargeModelFromJson(String str) => ShippingChargeModel.fromJson(json.decode(str));

String shippingChargeModelToJson(ShippingChargeModel data) => json.encode(data.toJson());

class ShippingChargeModel {
  int? maxAmount;
  int? shipingCharge;

  ShippingChargeModel({
    this.maxAmount,
    this.shipingCharge,
  });
  factory ShippingChargeModel.fromJson(Map<String, dynamic> json) => ShippingChargeModel(
    maxAmount: json["MaxAmount"],
    shipingCharge: json["ShipingCharge"],
  );
  Map<String, dynamic> toJson() => {
    "MaxAmount": maxAmount,
    "ShipingCharge": shipingCharge,
  };
}
