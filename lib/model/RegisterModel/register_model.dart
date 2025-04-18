class RegisterModel {
  final bool success;
  final String message;

  RegisterModel({required this.success, required this.message});

  // Factory constructor to create a RegisterModel instance from JSON data
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
