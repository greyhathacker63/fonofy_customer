import 'dart:convert';

// List<ListShippingAddressModel> listShippingAddressModelFromJson(String str) => List<ListShippingAddressModel>.from(json.decode(str).map((x) => ListShippingAddressModel.fromJson(x)));
//
// String listShippingAddressModelToJson(List<ListShippingAddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class ListShippingAddressModel {
  int? id;
  String? shippmentId;
  String? name;
  String? mobileNo;
  String? customerId;
  String? emailId;
  String? address;
  String? city;
  String? state;
  String? pinCode;
  String? workType;
  int? isdefault;

  ListShippingAddressModel({
    this.id,
    this.shippmentId,
    this.name,
    this.mobileNo,
    this.customerId,
    this.emailId,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    this.workType,
    this.isdefault,
  });
  factory ListShippingAddressModel.fromJson(Map<String, dynamic> json) => ListShippingAddressModel(
    id: json["Id"],
    shippmentId: json["ShippmentId"],
    name: json["Name"],
    mobileNo: json["MobileNo"],
    customerId: json["CustomerId"],
    emailId: json["EmailId"],
    address: json["Address"],
    city: json["City"],
    state: json["State"],
    pinCode: json["PinCode"],
    workType: json["WorkType"],
    isdefault: json["Isdefault"],
  );
  Map<String, dynamic> toJson() => {
    "Id": id,
    "ShippmentId": shippmentId,
    "Name": name,
    "MobileNo": mobileNo,
    "CustomerId": customerId,
    "EmailId": emailId,
    "Address": address,
    "City": city,
    "State": state,
    "PinCode": pinCode,
    "WorkType": workType,
    "Isdefault": isdefault,
  };
}
