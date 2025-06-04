// To parse this JSON data, do
//
//     final mobileOtpModel = mobileOtpModelFromJson(jsonString);

import 'dart:convert';

MobileOtpModel mobileOtpModelFromJson(String str) => MobileOtpModel.fromJson(json.decode(str));

String mobileOtpModelToJson(MobileOtpModel data) => json.encode(data.toJson());

class MobileOtpModel {
  String otp;
  String status;

  MobileOtpModel({
    required this.otp,
    required this.status,
  });

  factory MobileOtpModel.fromJson(Map<String, dynamic> json) => MobileOtpModel(
    otp: json["otp"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "status": status,
  };
}
