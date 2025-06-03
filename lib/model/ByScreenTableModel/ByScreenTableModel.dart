
import 'dart:convert';

ByTableModel byTableModelFromJson(String str) => ByTableModel.fromJson(json.decode(str));

String byTableModelToJson(ByTableModel data) => json.encode(data.toJson());

class ByTableModel {
  List<Table>? table;
  List<Table1Element>? table1;
  List<Table2Element>? table2;
  List<Table1Element>? table3;
  List<Table2Element>? table4;
  List<Table5>? table5;
  List<Table6>? table6;
  List<Table2Element>? table7;
  List<Table8>? table8;

  ByTableModel({
    this.table,
    this.table1,
    this.table2,
    this.table3,
    this.table4,
    this.table5,
    this.table6,
    this.table7,
    this.table8,
  });

  factory ByTableModel.fromJson(Map<String, dynamic> json) => ByTableModel(
    table: json["Table"] == null ? [] : List<Table>.from(json["Table"]!.map((x) => Table.fromJson(x))),
    table1: json["Table1"] == null ? [] : List<Table1Element>.from(json["Table1"]!.map((x) => Table1Element.fromJson(x))),
    table2: json["Table2"] == null ? [] : List<Table2Element>.from(json["Table2"]!.map((x) => Table2Element.fromJson(x))),
    table3: json["Table3"] == null ? [] : List<Table1Element>.from(json["Table3"]!.map((x) => Table1Element.fromJson(x))),
    table4: json["Table4"] == null ? [] : List<Table2Element>.from(json["Table4"]!.map((x) => Table2Element.fromJson(x))),
    table5: json["Table5"] == null ? [] : List<Table5>.from(json["Table5"]!.map((x) => Table5.fromJson(x))),
    table6: json["Table6"] == null ? [] : List<Table6>.from(json["Table6"]!.map((x) => Table6.fromJson(x))),
    table7: json["Table7"] == null ? [] : List<Table2Element>.from(json["Table7"]!.map((x) => Table2Element.fromJson(x))),
    table8: json["Table8"] == null ? [] : List<Table8>.from(json["Table8"]!.map((x) => Table8.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "Table": table == null ? [] : List<dynamic>.from(table!.map((x) => x.toJson())),
    "Table1": table1 == null ? [] : List<dynamic>.from(table1!.map((x) => x.toJson())),
    "Table2": table2 == null ? [] : List<dynamic>.from(table2!.map((x) => x.toJson())),
    "Table3": table3 == null ? [] : List<dynamic>.from(table3!.map((x) => x.toJson())),
    "Table4": table4 == null ? [] : List<dynamic>.from(table4!.map((x) => x.toJson())),
    "Table5": table5 == null ? [] : List<dynamic>.from(table5!.map((x) => x.toJson())),
    "Table6": table6 == null ? [] : List<dynamic>.from(table6!.map((x) => x.toJson())),
    "Table7": table7 == null ? [] : List<dynamic>.from(table7!.map((x) => x.toJson())),
    "Table8": table8 == null ? [] : List<dynamic>.from(table8!.map((x) => x.toJson())),
  };
}



class Table {
  dynamic id;
  String? title;
  String? tagLine;
  bool? isActive;
  dynamic sequenceId;
  String? ramdomCode;
  String? bnnerImage;
  String? cmpCode;
  bool? status;
  bool? isdeleted;
  DateTime? createdDate;
  dynamic createdby;
  dynamic updatedDate;
  dynamic updatedBy;

  Table({
    this.id,
    this.title,
    this.tagLine,
    this.isActive,
    this.sequenceId,
    this.ramdomCode,
    this.bnnerImage,
    this.cmpCode,
    this.status,
    this.isdeleted,
    this.createdDate,
    this.createdby,
    this.updatedDate,
    this.updatedBy,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
    id: json["Id"],
    title: json["Title"],
    tagLine: json["TagLine"],
    isActive: json["IsActive"],
    sequenceId: json["SequenceId"],
    ramdomCode: json["Ramdom_Code"],
    bnnerImage: json["BnnerImage"],
    cmpCode: json["Cmp_Code"],
    status: json["Status"],
    isdeleted: json["Isdeleted"],
    createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
    createdby: json["Createdby"],
    updatedDate: json["UpdatedDate"],
    updatedBy: json["UpdatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "TagLine": tagLine,
    "IsActive": isActive,
    "SequenceId": sequenceId,
    "Ramdom_Code": ramdomCode,
    "BnnerImage": bnnerImage,
    "Cmp_Code": cmpCode,
    "Status": status,
    "Isdeleted": isdeleted,
    "CreatedDate": createdDate?.toIso8601String(),
    "Createdby": createdby,
    "UpdatedDate": updatedDate,
    "UpdatedBy": updatedBy,
  };
}

class Table1Element {
  dynamic? id;
  String? brandName;
  BToC? bToC;
  String? offerImage;
  String? brandImage;

  Table1Element({
    this.id,
    this.brandName,
    this.bToC,
    this.offerImage,
    this.brandImage,
  });

  factory Table1Element.fromJson(Map<String, dynamic> json) => Table1Element(
    id: json["id"],
    brandName: json["BrandName"],
    bToC: bToCValues.map[json["BToC"]]!,
    offerImage: json["OfferImage"],
    brandImage: json["BrandImage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "BrandName": brandName,
    "BToC": bToCValues.reverse[bToC],
    "OfferImage": offerImage,
    "BrandImage": brandImage,
  };
}

enum BToC {
  B2_C
}

final bToCValues = EnumValues({
  "B2C": BToC.B2_C
});

class Table2Element {
  String? modelNo;
  String? productAndModelName;
  BToC? modelType;
  dynamic amount;
  String? image;
  dynamic? newModelAmt;
  dynamic? discountPercentage;
  dynamic? wishlistCount;
  String? modelUrl;
  dynamic? id;
  String? ucode;

  Table2Element({
    this.modelNo,
    this.productAndModelName,
    this.modelType,
    this.amount,
    this.image,
    this.newModelAmt,
    this.discountPercentage,
    this.wishlistCount,
    this.modelUrl,
    this.id,
    this.ucode,
  });

  factory Table2Element.fromJson(Map<String, dynamic> json) => Table2Element(
    modelNo: json["ModelNo"],
    productAndModelName: json["ProductAndModelName"],
    modelType: bToCValues.map[json["ModelType"]]!,
    amount: json["Amount"],
    image: json["Image"],
    newModelAmt: json["NewModelAmt"],
    discountPercentage: json["DiscountPercentage"],
    wishlistCount: json["WishlistCount"],
    modelUrl: json["ModelUrl"],
    id: json["id"],
    ucode: json["Ucode"],
  );

  Map<String, dynamic> toJson() => {
    "ModelNo": modelNo,
    "ProductAndModelName": productAndModelName,
    "ModelType": bToCValues.reverse[modelType],
    "Amount": amount,
    "Image": image,
    "NewModelAmt": newModelAmt,
    "DiscountPercentage": discountPercentage,
    "WishlistCount": wishlistCount,
    "ModelUrl": modelUrl,
    "id": id,
    "Ucode": ucode,
  };
}

class Table5 {
  String? ramName;
  dynamic? amount;

  Table5({
    this.ramName,
    this.amount,
  });

  factory Table5.fromJson(Map<String, dynamic> json) => Table5(
    ramName: json["RamName"],
    amount: json["Amount"],
  );

  Map<String, dynamic> toJson() => {
    "RamName": ramName,
    "Amount": amount,
  };
}

class Table6 {
  dynamic priceRange;
  String? image;

  Table6({
    this.priceRange,
    this.image,
  });

  factory Table6.fromJson(Map<String, dynamic> json) => Table6(
    priceRange: json["PriceRange"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "PriceRange": priceRange,
    "Image": image,
  };
}

class Table8 {
  dynamic name;
  String? image;
  dynamic id ;



  Table8({
    this.name,
    this.image,
    this.id,
  });

  factory Table8.fromJson(Map<String, dynamic> json) => Table8(
    name: json["Name"],
    image: json["Image"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Image": image,
    "Id": id,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
