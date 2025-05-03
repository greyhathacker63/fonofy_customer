
class AddToBuyNowModel {
  final String customerId;
  final dynamic quantity;
  final dynamic modelId;
  final dynamic colorId;
  final dynamic ramId;
  final dynamic romId;
  final String cartRef;

  AddToBuyNowModel({
    required this.customerId,
    required this.quantity,
    required this.modelId,
    required this.colorId,
    required this.ramId,
    required this.romId,
    required this.cartRef,
  });

  Map<String, dynamic> toJson() {
    return {
      "CustomerId": customerId,
      "Quantity": quantity,
      "ModelId": modelId,
      "ColorId": colorId,
      "RamId": ramId,
      "RomId": romId,
      "CartRef": cartRef,
    };
  }

  factory AddToBuyNowModel.fromJson(Map<String, dynamic> json) {
    return AddToBuyNowModel(
      customerId: json['CustomerId'] ?? '',
      quantity: json['Quantity'] ?? 0,
      modelId: json['ModelId'] ?? 0,
      colorId: json['ColorId'] ?? 0,
      ramId: json['RamId'] ?? 0,
      romId: json['RomId'] ?? 0,
      cartRef: json['CartRef'] ?? '',
    );
  }
}
