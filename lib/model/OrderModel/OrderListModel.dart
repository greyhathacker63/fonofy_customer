class OrderListModel {
  final String orderId;
  final String createdDate;
  final String image;

  OrderListModel({
    required this.orderId,
    required this.createdDate,
    required this.image,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      orderId: json['OrderId'] ?? '',
      createdDate: json['CreatedDate'] ?? '',
      image: json['Image'] ?? '',
    );
  }
}
