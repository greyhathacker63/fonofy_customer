// To parse this JSON data, do
//
//     final mobileOtp = mobileOtpFromJson(jsonString);

import 'dart:convert';

MobileOtp mobileOtpFromJson(String str) => MobileOtp.fromJson(json.decode(str));

String mobileOtpToJson(MobileOtp data) => json.encode(data.toJson());

class MobileOtp {
  String otp;
  String status;

  MobileOtp({
    required this.otp,
    required this.status,
  });

  factory MobileOtp.fromJson(Map<String, dynamic> json) => MobileOtp(
    otp: json["otp"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "status": status,
  };
}
