// class PhoneModel {
//  String? phoneNumber;
//  String? status;
//
//  PhoneModel({this.phoneNumber, this.status});
//
//  // Assuming these are the fields you want to capture from the API response
//  factory PhoneModel.fromJson(Map<String, dynamic> json) {
//   return PhoneModel(
//    phoneNumber: json['phone_number'], // Replace with actual field name from API
//    status: json['status'], // Replace with actual field name from API
//   );
//  }
//
//  // If you need to convert PhoneModel back to JSON for sending data to the API
//  Map<String, dynamic> toJson() {
//   return {
//    'phone_number': phoneNumber,
//    'status': status,
//   };
//  }
// }
