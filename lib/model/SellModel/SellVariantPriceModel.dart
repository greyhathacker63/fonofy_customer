import 'dart:convert';

List<SellVariantPriceModel> sellVariantPriceModelFromJson(String str) =>
    List<SellVariantPriceModel>.from(json.decode(str).map((x) => SellVariantPriceModel.fromJson(x)));

String sellVariantPriceModelToJson(List<SellVariantPriceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellVariantPriceModel {
  final double basePrice;
  final double maxPrice;
  final double minPrice;
  final String modelName;
  final String image;
  final String ramName;
  final String romName;
  final int brandId;
  final int modelId;
  final int ramId;
  final int romId;

  SellVariantPriceModel({
    required this.basePrice,
    required this.maxPrice,
    required this.minPrice,
    required this.modelName,
    required this.image,
    required this.ramName,
    required this.romName,
    required this.brandId,
    required this.modelId,
    required this.ramId,
    required this.romId,
  });

  factory SellVariantPriceModel.fromJson(Map<String, dynamic> json) => SellVariantPriceModel(
    basePrice: (json["BasePrice"] as num).toDouble(),
    maxPrice: (json["MaxPrice"] as num).toDouble(),
    minPrice: (json["MinPrice"] as num).toDouble(),
    modelName: json["ModelName"],
    image: json["Image"] ?? '',
    ramName: json["RamName"] ?? '',
    romName: json["RomName"] ?? '',
    brandId: json["BrandId"] ?? 0,
    modelId: json["ModelId"] ?? 0,
    ramId: json["RAMId"] ?? 0,
    romId: json["ROMId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "BasePrice": basePrice,
    "MaxPrice": maxPrice,
    "MinPrice": minPrice,
    "ModelName": modelName,
    "Image": image,
    "RamName": ramName,
    "RomName": romName,
    "BrandId": brandId,
    "ModelId": modelId,
    "RAMId": ramId,
    "ROMId": romId,
  };
}
