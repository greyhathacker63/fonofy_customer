<<<<<<< HEAD
// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String? token;

    RegisterModel({
        this.token,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
=======
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
>>>>>>> vinay/users
}
