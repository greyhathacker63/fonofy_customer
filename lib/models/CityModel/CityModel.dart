class CityModel {
  final int id;
  final int stateId;
  final String cityname;

  CityModel({required this.id, required this.stateId, required this.cityname});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      stateId: json['stateid'] is int
          ? json['stateid']
          : int.tryParse(json['stateid'].toString()) ?? 0,
      cityname: json['cityname'] ?? "Unknown",
    );
  }
  @override
  String toString() {
    return 'CityModel(id: $id, stateId: $stateId, cityname: $cityname)';
  }
}
