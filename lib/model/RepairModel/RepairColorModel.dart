import 'dart:convert';

List<RepairColorModel> repairColorModelFromJson(String str) =>
    List<RepairColorModel>.from(
        json.decode(str).map((x) => RepairColorModel.fromJson(x)));

String repairColorModelToJson(List<RepairColorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairColorModel {
  String? brand;
  String? modelNo;
  int? colorId;
  String? colorName;
  String? colorImage;

  RepairColorModel({
    this.brand,
    this.modelNo,
    this.colorId,
    this.colorName,
    this.colorImage,
  });

  factory RepairColorModel.fromJson(Map<String, dynamic> json) =>
      RepairColorModel(
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
