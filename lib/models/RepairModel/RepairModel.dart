import 'dart:convert';

List<RepairModel> repairModelFromJson(String str) =>
    List<RepairModel>.from(
        json.decode(str).map((x) => RepairModel.fromJson(x)));

String repairModelToJson(List<RepairModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairModel {
  String? brand;
  String? modelNo;
  int? colorId;
  String? colorName;
  String? colorImage;

  RepairModel({
    this.brand,
    this.modelNo,
    this.colorId,
    this.colorName,
    this.colorImage,
  });

  factory RepairModel.fromJson(Map<String, dynamic> json) =>
      RepairModel(
        brand: json["Brand"],
        modelNo: json["ModelNo"],
        colorId: json["ColorId"],
        colorName: json["ColorName"],
        colorImage: json["ColorImage"],
      );

  Map<String, dynamic> toJson() => {
        "Brand": brand,
        "ModelNo": modelNo,
        "ColorId": colorId,
        "ColorName": colorName,
        "ColorImage": colorImage,
      };
}
