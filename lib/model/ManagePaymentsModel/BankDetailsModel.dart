class BankDetailsRequest {
  final String accountNumber;
  final String confirmAccountNumber;
  final String beneficiaryName;
  final String ifscCode;
  final String bankName;
  final String customerId;
  final bool isDeclarationAccepted;

  BankDetailsRequest({
    required this.accountNumber,
    required this.confirmAccountNumber,
    required this.beneficiaryName,
    required this.ifscCode,
    required this.bankName,
    required this.customerId,
    required this.isDeclarationAccepted,
  });

  Map<String, dynamic> toJson() => {
        "AccountNumber": accountNumber,
        "ConfirmAccountNumber": confirmAccountNumber,
        "BeneficiaryName": beneficiaryName,
        "IFSCCode": ifscCode,
        "BankName": bankName,
        "CustomerId": customerId,
        "IsDeclarationAccepted": isDeclarationAccepted,
      };
}

class BankDetails {
  final int id;
  final String accountNumber;
  final String beneficiaryName;
  final String ifscCode;
  final String bankName;
  final String customerId;
  final bool isVerified;
  final String type;

  BankDetails({
    required this.id,
    required this.accountNumber,
    required this.beneficiaryName,
    required this.ifscCode,
    required this.bankName,
    required this.customerId,
    required this.isVerified,
    required this.type,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      id: json['Id'] as int? ?? 0,
      accountNumber: json['AccountNumber'] as String? ?? '',
      beneficiaryName: json['BeneficiaryName'] as String? ?? '',
      ifscCode: json['IFSCCode'] as String? ?? '',
      bankName: json['BankName'] as String? ?? '',
      customerId: json['CustomerId'] as String? ?? '',
      isVerified: json['IsVerified'] as bool? ?? false,
      type: json['Type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'beneficiaryName': beneficiaryName,
      'ifscCode': ifscCode,
      'bankName': bankName,
      'customerId': customerId,
      'isVerified': isVerified,
      'type': type,
    };
  }
}
class UpiDetails {
  final String? upiId;
  final String? customerId;
  final int? id;

  UpiDetails({this.upiId, this.customerId, this.id});

  factory UpiDetails.fromJson(Map<String, dynamic> json) {
    return UpiDetails(
      id: json['Id'],
      customerId: json['CustomerId'],
      upiId: json['AccountNumber'], // <-- Key Fix
    );
  }
}
