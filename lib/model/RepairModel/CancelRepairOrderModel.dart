class CancelRepairOrderModel {
  final String message;

  CancelRepairOrderModel({required this.message});

  factory CancelRepairOrderModel.fromJson(Map<String, dynamic> json) {
    return CancelRepairOrderModel(
      message: json['message'] ?? '',
    );
  }
}