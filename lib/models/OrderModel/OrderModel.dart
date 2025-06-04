class OrderModel {
  final String orderId;
  final String createdDate;
  final String image;

  OrderModel({
    required this.orderId,
    required this.createdDate,
    required this.image,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['OrderId'] ?? '',
      createdDate: json['CreatedDate'] ?? '',
      image: json['Image'] ?? '',
    );
  }
}
