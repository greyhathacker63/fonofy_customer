class PhoneLoginModel {
  final String? token;

  PhoneLoginModel({this.token});

  factory PhoneLoginModel.fromJson(Map<String, dynamic> json) {
    return PhoneLoginModel(
      token: json['token'],
    );
  }
}
