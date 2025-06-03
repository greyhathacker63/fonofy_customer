// To parse this JSON data, do
//
//     final sellTestimonialListModel = sellTestimonialListModelFromJson(jsonString);

import 'dart:convert';

List<SellTestimonialListModel> sellTestimonialListModelFromJson(String str) => List<SellTestimonialListModel>.from(json.decode(str).map((x) => SellTestimonialListModel.fromJson(x)));

String sellTestimonialListModelToJson(List<SellTestimonialListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellTestimonialListModel {
  int? id;
  String? name;
  String? image;
  String? description;

  SellTestimonialListModel({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  factory SellTestimonialListModel.fromJson(Map<String, dynamic> json) => SellTestimonialListModel(
    id: json["Id"],
    name: json["Name"],
    image: json["Image"],
    description: json["Description"],
  );



  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Image": image,
    "Description": description,
  };
}
