class WishlistModel {
  final dynamic productId;
  final dynamic customerId;
  final dynamic modelID;
  final dynamic status;
  final dynamic productAndModelName;
  final dynamic image;
  final dynamic modelNo;
  final dynamic f2;
  final dynamic rowCode;
  final dynamic ramName;
  final dynamic romName;
  final dynamic colorName;
  final dynamic ucode;
  final dynamic modelUrl;
  final dynamic reviewCount;
  final dynamic ramId;
  final dynamic romId;
  final dynamic colorId;

  WishlistModel({
    this.productId,
    this.customerId,
    this.modelID,
    this.status,
    this.productAndModelName,
    this.image,
    this.modelNo,
    this.f2,
    this.rowCode,
    this.ramName,
    this.romName,
    this.colorName,
    this.ucode,
    this.modelUrl,
    this.reviewCount,
    this.ramId,
    this.romId,
    this.colorId,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      productId: json['Id'] as dynamic,
      customerId: json['CustomerId'] as dynamic,
      modelID: json['modelID'] as dynamic,
      status: json['Status'] as dynamic,
      productAndModelName: json['ProductAndModelName'] as dynamic,
      image: json['Image'] as dynamic,
      modelNo: json['ModelNo'] as dynamic,
      f2: json['F2'] as dynamic,
      rowCode: json['RowCode'] as dynamic,
      ramName: json['RamName'] as dynamic,
      romName: json['RomName'] as dynamic,
      colorName: json['ColorName'] as dynamic,
      ucode: json['Ucode'] as dynamic,
      modelUrl: json['ModelUrl'] as dynamic,
      reviewCount: json['ReviewCount'] as dynamic,
      ramId: json['RamId'] as dynamic,
      romId: json['RomId'] as dynamic,
      colorId: json['ColorId'] as dynamic,
    );
  }
}
