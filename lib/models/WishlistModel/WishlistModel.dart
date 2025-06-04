class WishlistModel {
  final int id;
  final String customerId;
  final bool status;
  final String productAndModelName;
  final String? image;
  final int modelNo;
  final double price;
  final String rowCode;
  final String ramName;
  final String romName;
  final String colorName;
  final String ucode;
  final String modelUrl;
  final int reviewCount;
  final int ramId;
  final int romId;
  final int colorId;

  WishlistModel({
    required this.id,
    required this.customerId,
    required this.status,
    required this.productAndModelName,
    required this.image,
    required this.modelNo,
    required this.price,
    required this.rowCode,
    required this.ramName,
    required this.romName,
    required this.colorName,
    required this.ucode,
    required this.modelUrl,
    required this.reviewCount,
    required this.ramId,
    required this.romId,
    required this.colorId,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['Id'] ?? 0,
      customerId: json['CustomerId']?.toString() ?? '',
      status: json['Status'] ?? false,
      productAndModelName: json['ProductAndModelName'] ?? '',
      image: json['Image'],
      modelNo: json['ModelNo'] ?? 0,
      price: (json['F2'] ?? 0).toDouble(),
      rowCode: json['RowCode'] ?? '',
      ramName: json['RamName'] ?? '',
      romName: json['RomName'] ?? '',
      colorName: json['ColorName'] ?? '',
      ucode: json['Ucode'] ?? '',
      modelUrl: json['ModelUrl'] ?? '',
      reviewCount: json['ReviewCount'] ?? 0,
      ramId: json['RamId'] ?? 0,
      romId: json['RomId'] ?? 0,
      colorId: json['ColorId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'CustomerId': customerId,
      'Status': status,
      'ProductAndModelName': productAndModelName,
      'Image': image,
      'ModelNo': modelNo,
      'F2': price,
      'RowCode': rowCode,
      'RamName': ramName,
      'RomName': romName,
      'ColorName': colorName,
      'Ucode': ucode,
      'ModelUrl': modelUrl,
      'ReviewCount': reviewCount,
      'RamId': ramId,
      'RomId': romId,
      'ColorId': colorId,
    };
  }
}
