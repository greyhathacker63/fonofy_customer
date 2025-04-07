class RomModel {
  final int id;
  final String romName;

  RomModel({required this.id, required this.romName});

  factory RomModel.fromJson(Map<String, dynamic> json) {
    return RomModel(
      id: json['id'],
      romName: json['RomName'],
    );
  }
}
