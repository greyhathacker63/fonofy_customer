// To parse this JSON data, do
//
//     final productImageListModel = productImageListModelFromJson(jsonString);

// import 'dart:convert';
//
// List<ProductImageListModel> productImageListModelFromJson(String str) => List<ProductImageListModel>.from(json.decode(str).map((x) => ProductImageListModel.fromJson(x)));
//
// String productImageListModelToJson(List<ProductImageListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class ProductImageListModel {
//   int? id;
//   int? modelId;
//   String? image;
//   bool? status;
//   bool? isdelete;
//   DateTime? createDate;
//   int? topImage;
//   int? ramId;
//   int? romId;
//   int? colorId;
//   RowCode? rowCode;
//   SpecificationsUcode? specificationsUcode;
//
//   ProductImageListModel({
//     this.id,
//     this.modelId,
//     this.image,
//     this.status,
//     this.isdelete,
//     this.createDate,
//     this.topImage,
//     this.ramId,
//     this.romId,
//     this.colorId,
//     this.rowCode,
//     this.specificationsUcode,
//   });
//
//   factory ProductImageListModel.fromJson(Map<String, dynamic> json) => ProductImageListModel(
//     id: json["Id"],
//     modelId: json["ModelId"],
//     image: json["Image"],
//     status: json["Status"],
//     isdelete: json["Isdelete"],
//     createDate: json["CreateDate"] == null ? null : DateTime.parse(json["CreateDate"]),
//     topImage: json["TopImage"],
//     ramId: json["RamId"],
//     romId: json["RomId"],
//     colorId: json["ColorId"],
//     rowCode: rowCodeValues.map[json["RowCode"]]!,
//     specificationsUcode: specificationsUcodeValues.map[json["specificationsUcode"]]!,
//   );
//
//   get productImages => null;
//
//   Map<String, dynamic> toJson() => {
//     "Id": id,
//     "ModelId": modelId,
//     "Image": image,
//     "Status": status,
//     "Isdelete": isdelete,
//     "CreateDate": createDate?.toIso8601String(),
//     "TopImage": topImage,
//     "RamId": ramId,
//     "RomId": romId,
//     "ColorId": colorId,
//     "RowCode": rowCodeValues.reverse[rowCode],
//     "specificationsUcode": specificationsUcodeValues.reverse[specificationsUcode],
//   };
// }
//
// enum RowCode {
//   ROW_241520251115137428125,
//   ROW_2415202511151382111155
// }
//
// final rowCodeValues = EnumValues({
//   "Row_241520251115137428125": RowCode.ROW_241520251115137428125,
//   "Row_2415202511151382111155": RowCode.ROW_2415202511151382111155
// });
//
// enum SpecificationsUcode {
//   THE_24152025111513742_C8_E778_D3_A6_D8_4729_A36_F_807_C7_CD57_AC5
// }
//
// final specificationsUcodeValues = EnumValues({
//   "24152025111513742c8e778d3-a6d8-4729-a36f-807c7cd57ac5": SpecificationsUcode.THE_24152025111513742_C8_E778_D3_A6_D8_4729_A36_F_807_C7_CD57_AC5
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }


// Model Class for ProductImageList
import 'dart:convert';

class ProductImageListModel {
  final String? image;

  ProductImageListModel({this.image});

  factory ProductImageListModel.fromJson(Map<String, dynamic> json) {
    return ProductImageListModel(
      image: json['Image'],
    );
  }
}

List<ProductImageListModel> productImageListModelFromJson(String str) {
  final jsonData = json.decode(str);
  return List<ProductImageListModel>.from(
    jsonData.map((item) => ProductImageListModel.fromJson(item)),
  );
}
