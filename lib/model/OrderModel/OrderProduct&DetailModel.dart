class OrderProductModel {
  final String productName;
  final int quantity;
  final double price;
  final String productImage;

  OrderProductModel({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.productImage,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      productName: json['ProductName'],
      quantity: json['Quantity'],
      price: (json['Price'] ?? 0).toDouble(),
      productImage: json['ProductImage'] ?? '',
    );
  }
}
class OrderDetailModel {
  final String orderStatus;
  final double totalPrice;
  final String shippingAddress;
  final String ShippingName;
  final String ShippingMobileNo;
  final String ShippingEmailId;
  final String ShippingCity;
  final String ShippingState;

  OrderDetailModel({
    required this.orderStatus,
    required this.totalPrice,
    required this.shippingAddress,
    required this.ShippingName,
    required this.ShippingMobileNo,
    required this.ShippingEmailId,
    required this.ShippingCity,
    required this.ShippingState,

  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      orderStatus: json['OrderStatus'],
      totalPrice: (json['TotalPrice'] ?? 0).toDouble(),
      shippingAddress: json['ShippingAddress'], ShippingCity: '', ShippingState: '',
      ShippingName:json['ShippingName'],
      ShippingMobileNo:json['ShippingMobileNo'],
      ShippingEmailId:json['ShippingEmailId']
    );
  }
}
