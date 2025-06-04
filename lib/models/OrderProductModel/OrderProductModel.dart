class OrderProductModel {
  final int productId;
  final String productName;
  final int quantity;
  final double price;
  final String productImage;
  final int colorId;
  final int ramId;
  final int romId;

  OrderProductModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.productImage,
    required this.colorId,
    required this.ramId,
    required this.romId,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      productId: json['ProductId'] ?? 0,
      productName: json['ProductName'] ?? '',
      quantity: json['Quantity'] ?? 0,
      price: (json['Price'] ?? 0).toDouble(),
      productImage: json['ProductImage'] ?? '',
      colorId: json['ColorId'] ?? 0,
      ramId: json['RamId'] ?? 0,
      romId: json['RomId'] ?? 0,
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
