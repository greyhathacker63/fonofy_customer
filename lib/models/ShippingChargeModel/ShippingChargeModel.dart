class ShippingChargeModel {
  final double maxAmount;
  final double shippingCharge;

  ShippingChargeModel({
    required this.maxAmount,
    required this.shippingCharge,
  });

  factory ShippingChargeModel.fromJson(Map<String, dynamic> json) => ShippingChargeModel(
    maxAmount: (json["MaxAmount"] ?? 0).toDouble(),
    shippingCharge: (json["ShipingCharge"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "MaxAmount": maxAmount,
    "ShipingCharge": shippingCharge,
  };
}
