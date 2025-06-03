// To parse this JSON data, do
//
//     final sellTestimonialListModel = sellTestimonialListModelFromJson(jsonString);

import 'dart:convert';

List<RepairTestimonialListModel> sellTestimonialListModelFromJson(String str) => List<RepairTestimonialListModel>.from(json.decode(str).map((x) => RepairTestimonialListModel.fromJson(x)));

String sellTestimonialListModelToJson(List<RepairTestimonialListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepairTestimonialListModel {
  int? id;
  String? name;
  String? image;
  String? description;

  RepairTestimonialListModel({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  factory RepairTestimonialListModel.fromJson(Map<String, dynamic> json) => RepairTestimonialListModel(
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
