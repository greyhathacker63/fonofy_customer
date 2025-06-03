class SellVariantTableModel {
  List<Table> table;
  List<Table1> table1;

  SellVariantTableModel({
    required this.table,
    required this.table1,
  });

  factory SellVariantTableModel.fromJson(Map<String, dynamic> json) {
    return SellVariantTableModel(
      table: (json['Table'] as List<dynamic>?)
          ?.map((e) => Table.fromJson(e))
          .toList() ??
          [],
      table1: (json['Table1'] as List<dynamic>?)
          ?.map((e) => Table1.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Table {
  final int? romId;
  final int? ramId;
  final String romName;
  final String ramName;
  final String modelNo;
  final String modelName;
  final String image;

  Table({
    this.romId,
    this.ramId,
    required this.romName,
    required this.ramName,
    required this.modelNo,
    required this.modelName,
    required this.image,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      romId: json['ROMId'] is int ? json['ROMId'] : int.tryParse(json['ROMId'].toString()),
      ramId: json['RAMId'] is int ? json['RAMId'] : int.tryParse(json['RAMId'].toString()),
      romName: json['RomName'] ?? '',
      ramName: json['RamName'] ?? '',
      modelNo: json['ModelNo'] ?? '',
      modelName: json['ModelName'] ?? '',
      image: json['Image'] ?? '',
    );
  }
}

class Table1 {
  final String modelName;
  final String image;

  Table1({
    required this.modelName,
    required this.image,
  });

  factory Table1.fromJson(Map<String, dynamic> json) {
    return Table1(
      modelName: json['ModelName'] ?? '',
      image: json['Image'] ?? '',
    );
  }
}
