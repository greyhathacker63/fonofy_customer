import 'dart:convert';

RepairServicesTableModel repairServicesTableModelFromJson(String str) =>
    RepairServicesTableModel.fromJson(json.decode(str));

String repairServicesTableModelToJson(RepairServicesTableModel data) =>
    json.encode(data.toJson());

class RepairServicesTableModel {
  List<RepairDeviceTable>? table;
  List<Table1>? table1;

  RepairServicesTableModel({
    this.table,
    this.table1,
  });

  factory RepairServicesTableModel.fromJson(Map<String, dynamic> json) =>
      RepairServicesTableModel(
        table: json["Table"] == null
            ? []
            : List<RepairDeviceTable>.from(
                json["Table"].map((x) => RepairDeviceTable.fromJson(x))),
        table1: json["Table1"] == null
            ? []
            : List<Table1>.from(json["Table1"].map((x) => Table1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": table == null
            ? []
            : List<dynamic>.from(table!.map((x) => x.toJson())),
        "Table1": table1 == null
            ? []
            : List<dynamic>.from(table!.map((x) => x.toJson())),
      };
}

class RepairDeviceTable {
  String? brand;
  String? modelNo;
  int? colorId;
  String? colorName;
  String? productAndModelName;
  String? ramId;
  String? romId;

  RepairDeviceTable({
    this.brand,
    this.modelNo,
    this.colorId,
    this.colorName,
    this.productAndModelName,
    this.ramId,
    this.romId,
  });

  factory RepairDeviceTable.fromJson(Map<String, dynamic> json) =>
      RepairDeviceTable(
        brand: json["Brand"],
        modelNo: json["ModelNo"],
        colorId: json["ColorId"],
        colorName: json["ColorName"],
        productAndModelName: json["ProductAndModelName"],
        ramId: json["RamId"],
        romId: json["RomId"],
      );

  Map<String, dynamic> toJson() => {
        "Brand": brand,
        "ModelNo": modelNo,
        "ColorId": colorId,
        "ColorName": colorName,
        "ProductAndModelName": productAndModelName,
        "RamId": ramId,
        "RomId": romId,
      };
}

class Table1 {
  int? id;
  String? serviceName;
  String? serviceImage;
  double? mrp;
  double? discountAmount;
  double? disPercentage;
  double? price;

  String? serviceId;
  double? serviceAmount;
  double? serviceDiscount;
  double? servicePercent;

  Table1({
    this.id,
    this.serviceName,
    this.serviceImage,
    this.mrp,
    this.discountAmount,
    this.disPercentage,
    this.price,
    this.serviceId,
    this.serviceAmount,
    this.serviceDiscount,
    this.servicePercent,
  });

  factory Table1.fromJson(Map<String, dynamic> json) => Table1(
        id: json["Id"],
        serviceName: json["ServiceName"],
        serviceImage: json["ServiceImage"],
        mrp: (json["MRP"] ?? 0).toDouble(),
        discountAmount: (json["DiscountAmount"] ?? 0).toDouble(),
        disPercentage: (json["DisPercentage"] ?? 0).toDouble(),
        price: (json["Price"] ?? 0).toDouble(),
        serviceId: json["ServiceId"]?.toString(),
        serviceAmount:
            double.tryParse(json["ServiceAmount"]?.toString() ?? '0') ?? 0.0,
        serviceDiscount:
            double.tryParse(json["ServiceDiscount"]?.toString() ?? '0') ?? 0.0,
        servicePercent:
            double.tryParse(json["ServicePercent"]?.toString() ?? '0') ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "ServiceName": serviceName,
        "ServiceImage": serviceImage,
        "MRP": mrp,
        "DiscountAmount": discountAmount,
        "DisPercentage": disPercentage,
        "Price": price,
        "ServiceId": serviceId,
        "ServiceAmount": serviceAmount,
        "ServiceDiscount": serviceDiscount,
        "ServicePercent": servicePercent,
      };
}
