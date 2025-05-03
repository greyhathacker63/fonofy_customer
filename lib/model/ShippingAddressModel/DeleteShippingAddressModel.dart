class DeleteShippingAddressModel {
  final bool status;
  final String message;

  DeleteShippingAddressModel({
    required this.status,
    required this.message,
  });

  factory DeleteShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return DeleteShippingAddressModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
