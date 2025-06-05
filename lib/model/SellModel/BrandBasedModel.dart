import 'dart:convert';

/// Main parser function
BrandBasedResponse brandBasedModelFromJson(String str) =>
    BrandBasedResponse.fromJson(json.decode(str));

/// Convert back to JSON string if needed
String brandBasedModelToJson(BrandBasedResponse data) =>
    json.encode(data.toJson());

/// Main response class
class BrandBasedResponse {
  List<BrandBasedModel> models;
  List<BrandSeries> series;

  BrandBasedResponse({
    required this.models,
    required this.series,
  });

  factory BrandBasedResponse.fromJson(Map<String, dynamic> json) =>
      BrandBasedResponse(
        models: List<BrandBasedModel>.from(
            json["Table"].map((x) => BrandBasedModel.fromJson(x))),
        series: List<BrandSeries>.from(
            json["Table1"].map((x) => BrandSeries.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(models.map((x) => x.toJson())),
        "Table1": List<dynamic>.from(series.map((x) => x.toJson())),
      };
}

/// Model for each item in "Table"
class BrandBasedModel {
  int brandId;
  int productId;
  String? productAndModelName;
  String? image;

  BrandBasedModel({
    required this.brandId,
    required this.productId,
    this.productAndModelName,
    this.image,
  });

  factory BrandBasedModel.fromJson(Map<String, dynamic> json) =>
      BrandBasedModel(
        brandId: json["BrandId"],
        productId: json["ProductId"],
        productAndModelName: json["ProductAndModelName"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "BrandId": brandId,
        "ProductId": productId,
        "ProductAndModelName": productAndModelName,
        "Image": image,
      };
}

/// Model for each item in "Table1"
class BrandSeries {
  String seriesName;
  String brandName;
  String? seriesImage;
  int seriesId;
  int brandId;

  BrandSeries({
    required this.seriesName,
    required this.brandName,
    this.seriesImage,
    required this.seriesId,
    required this.brandId,
  });

  factory BrandSeries.fromJson(Map<String, dynamic> json) => BrandSeries(
        seriesName: json["SeriesName"],
        brandName: json["BrandName"],
        seriesImage: json["SeriesImage"],
        seriesId: json["SeriesId"],
        brandId: json["brandId"],
      );

  Map<String, dynamic> toJson() => {
        "SeriesName": seriesName,
        "BrandName": brandName,
        "SeriesImage": seriesImage,
        "SeriesId": seriesId,
        "brandId": brandId,
      };
}

class SeriesItem {
  final String? seriesName;
  final String? brandName;
  final String? seriesImage;
  final int? seriesId;
  final int? brandId;

  SeriesItem({this.seriesName, this.brandName, this.seriesImage, this.seriesId, this.brandId});

  factory SeriesItem.fromJson(Map<String, dynamic> json) {
    return SeriesItem(
      seriesName: json['SeriesName'],
      brandName: json['BrandName'],
      seriesImage: json['SeriesImage'],
      seriesId: json['SeriesId'],
      brandId: json['brandId'],
    );
  }
}

class ProductItem {
  final int? productId;
  final String? productAndModelName;
  final String? image;
  final int? brandId;

  ProductItem({this.productId, this.productAndModelName, this.image, this.brandId});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      productId: json['ProductId'],
      productAndModelName: json['ProductAndModelName'],
      image: json['Image'],
      brandId: json['BrandId'],
    );
  }
}
