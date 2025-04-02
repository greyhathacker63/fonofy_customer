
class AddShippingAddressModel {
  int id;
  String shipmentId;
  String name;
  String mobileNo;
  String customerId;
  String emailId;
  String address;
  String city;
  String state;
  String pinCode;
  String workType;
  int isDefault;

  AddShippingAddressModel({
    required this.id,
    required this.shipmentId,
    required this.name,
    required this.mobileNo,
    required this.customerId,
    required this.emailId,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.workType,
    required this.isDefault,
  });

  factory AddShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return AddShippingAddressModel(
      id: json["Id"] ?? 0,
      shipmentId: json["ShipmentId"] ?? "",
      name: json["Name"] ?? "",
      mobileNo: json["MobileNo"] ?? "",
      customerId: json["CustomerId"] ?? "",
      emailId: json["EmailId"] ?? "",
      address: json["Address"] ?? "",
      city: json["City"] ?? "",
      state: json["State"] ?? "",
      pinCode: json["PinCode"] ?? "",
      workType: json["WorkType"] ?? "",
      isDefault: json["IsDefault"] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "ShipmentId": shipmentId,
      "Name": name,
      "MobileNo": mobileNo,
      "CustomerId": customerId,
      "EmailId": emailId,
      "Address": address,
      "City": city,
      "State": state,
      "PinCode": pinCode,
      "WorkType": workType,
      "IsDefault": isDefault,
    };
  }
}
