// class LocationModel {
//   final int id;
//   final String locationName;
//
//   LocationModel({required this.id, required this.locationName});
//
//   factory LocationModel.fromJson(Map<String, dynamic> json) {
//     return LocationModel(
//       id: json['id'],
//       locationName: json['LocationName'],
//     );
//   }
// }
//
//

class LocationModel {
  final int id;
  final String locationName;

  LocationModel({required this.id, required this.locationName});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      locationName: json['LocationName'] ?? "Unknown",
    );
  }

  @override
  String toString() {
    return 'LocationModel(id: $id, locationName: $locationName)';
  }
}
