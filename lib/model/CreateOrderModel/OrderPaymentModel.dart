
class OrderPaymentModel {
  final String paymentId;
  final String customerId;
  final String orderType;
  final String orderId;
  final double paymentAmount;

  OrderPaymentModel({
    required this.paymentId,
    required this.customerId,
    required this.orderType,
    required this.orderId,
    required this.paymentAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      "PaymentId": paymentId,
      "CustomerId": customerId,
      "OrderType": orderType,
      "OrderId": orderId,
      "PaymentAmount": paymentAmount,
    };
  }
}
