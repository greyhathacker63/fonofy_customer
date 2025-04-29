// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(String str) => AddToCartModel.fromJson(json.decode(str));

String addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
  String? massage;
  Result? result;

  AddToCartModel({
    this.massage,
    this.result,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
    massage: json["massage"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );



  Map<String, dynamic> toJson() => {
    "massage": massage,
    "result": result?.toJson(),
  };
}

class Result {
  dynamic? id;
  dynamic? productId;
  String? customerId;
  DateTime? createdDate;
  dynamic updatedDate;
  bool? status;
  dynamic? quantity;
  String? type;
  dynamic? modelId;
  dynamic? brandId;
  dynamic? colorId;
  int? ramId;
  int? romId;
  String? cartRef;

  Result({
    this.id,
    this.productId,
    this.customerId,
    this.createdDate,
    this.updatedDate,
    this.status,
    this.quantity,
    this.type,
    this.modelId,
    this.brandId,
    this.colorId,
    this.ramId,
    this.romId,
    this.cartRef,
  });
  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    productId: json["ProductId"],
    customerId: json["CustomerId"],
    createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
    updatedDate: json["UpdatedDate"],
    status: json["Status"],
    quantity: json["Quantity"],
    type: json["Type"],
    modelId: json["ModelId"],
    brandId: json["BrandId"],
    colorId: json["ColorId"],
    ramId: json["RamId"],
    romId: json["RomId"],
    cartRef: json["CartRef"],
  );
  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProductId": productId,
    "CustomerId": customerId,
    "CreatedDate": createdDate?.toIso8601String(),
    "UpdatedDate": updatedDate,
    "Status": status,
    "Quantity": quantity,
    "Type": type,
    "ModelId": modelId,
    "BrandId": brandId,
    "ColorId": colorId,
    "RamId": ramId,
    "RomId": romId,
    "CartRef": cartRef,
  };
}


