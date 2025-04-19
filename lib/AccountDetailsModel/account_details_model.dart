
 class AccountDetailsModel {
  final String userCode;
  final String firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final String? address;
  final String role;
  final bool isActive;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String? password;
  final String? platformType;

  AccountDetailsModel({
    required this.userCode,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.phoneNumber,
    this.address,
    required this.role,
    required this.isActive,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    this.password,
    this.platformType,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsModel(
      userCode: json["UserCode"] ?? '',
      firstName: json["FirstName"] ?? 'N/A',
      lastName: json["LastName"],
      email: json["Email"] ?? 'N/A',
      phoneNumber: json["PhoneNumber"] ?? '',
      address: json["Address"],
      role: json["Role"] ?? 'User',
      isActive: json["IsActive"] ?? false,
      isEmailVerified: json["IsEmailVerified"] ?? false,
      isPhoneVerified: json["IsPhoneVerified"] ?? false,
      password: json["Password"],
      platformType: json["PlatformType"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "UserCode": userCode,
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "Address": address,
      "Role": role,
      "IsActive": isActive,
      "IsEmailVerified": isEmailVerified,
      "IsPhoneVerified": isPhoneVerified,
      "Password": password,
      "PlatformType": platformType,
    };
  }
}


