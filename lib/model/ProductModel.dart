class ProductModel {
  final String? ramName;
  final String? romName;
  final String? colorName;
  final int? colorId;
  final int? ramId;
  final int? romId;
  final String? modelNo;
  final String? productAndModelName;
  final String? modelType;
  final int? amount;
  final String? image;
  final int? newModelAmt;
  final int? discountPercentage;
  final String? modelUrl;
  final int? id;
  final String? ucode;
  final int? wishlistCount;
  final int? cartQuantity;

  ProductModel({
    this.ramName,
    this.romName,
    this.colorName,
    this.colorId,
    this.ramId,
    this.romId,
    this.modelNo,
    this.productAndModelName,
    this.modelType,
    this.amount,
    this.image,
    this.newModelAmt,
    this.discountPercentage,
    this.modelUrl,
    this.id,
    this.ucode,
    this.wishlistCount,
    this.cartQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      ramName: json["RamName"],
      romName: json["RomName"],
      colorName: json["ColorName"],
      colorId: (json["ColorId"] as num?)?.toInt(),
      ramId: (json["RamId"] as num?)?.toInt(),
      romId: (json["RomId"] as num?)?.toInt(),
      modelNo: json["ModelNo"],
      productAndModelName: json["ProductAndModelName"],
      modelType: json["ModelType"],
      amount: (json["Amount"] as num?)?.toInt(),
      image: json["Image"],
      newModelAmt: (json["NewModelAmt"] as num?)?.toInt(),
      discountPercentage: (json["DiscountPercentage"] as num?)?.toInt(),
      modelUrl: json["ModelUrl"],
      id: (json["id"] as num?)?.toInt(),
      ucode: json["Ucode"],
      wishlistCount: (json["WishlistCount"] as num?)?.toInt(),
      cartQuantity: (json["CartQuantity"] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "RamName": ramName,
      "RomName": romName,
      "ColorName": colorName,
      "ColorId": colorId,
      "RamId": ramId,
      "RomId": romId,
      "ModelNo": modelNo,
      "ProductAndModelName": productAndModelName,
      "ModelType": modelType,
      "Amount": amount,
      "Image": image,
      "NewModelAmt": newModelAmt,
      "DiscountPercentage": discountPercentage,
      "ModelUrl": modelUrl,
      "id": id,
      "Ucode": ucode,
      "WishlistCount": wishlistCount,
      "CartQuantity": cartQuantity,
    };
  }
}
