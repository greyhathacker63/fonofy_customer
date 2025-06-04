import 'dart:convert';

List<SellVariantPriceModel> sellVariantPriceModelFromJson(String str) =>
    List<SellVariantPriceModel>.from(json.decode(str).map((x) => SellVariantPriceModel.fromJson(x)));

String sellVariantPriceModelToJson(List<SellVariantPriceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellVariantPriceModel {
  dynamic basePrice;
  dynamic maxPrice;
  dynamic minPrice;
  String modelName;
  String image;
  String ramName;
  String romName;

  SellVariantPriceModel({
    required this.basePrice,
    required this.maxPrice,
    required this.minPrice,
    required this.modelName,
    required this.image,
    required this.ramName,
    required this.romName,
  });

  factory SellVariantPriceModel.fromJson(Map<dynamic, dynamic> json) => SellVariantPriceModel(
    basePrice: json["BasePrice"] ?? '',
    maxPrice: json["MaxPrice"] ?? '',
    minPrice: json["MinPrice"] ?? '',
    modelName: json["ModelName"] ?? '',
    image: json["Image"] ?? '',
    ramName: json["RamName"] ?? '',
    romName: json["RomName"] ?? '',
  );

  Map<dynamic, dynamic> toJson() => {
    "BasePrice": basePrice,
    "MaxPrice": maxPrice,
    "MinPrice": minPrice,
    "ModelName": modelName,
    "Image": image,
    "RamName": ramName,
    "RomName": romName,
  };
}