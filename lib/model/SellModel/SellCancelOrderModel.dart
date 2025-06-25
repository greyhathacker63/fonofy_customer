class SellCancelOrderModel {
  final String message;

  SellCancelOrderModel({required this.message});

  factory SellCancelOrderModel.fromJson(Map<String, dynamic> json) {
    return SellCancelOrderModel(
      message: json['message'] ?? '',
    );
  }
}