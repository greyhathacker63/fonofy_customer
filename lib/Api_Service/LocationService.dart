// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/CityModel.dart';
// import '../model/LocationModel.dart';
//
// class LocationService {
//   static const String baseUrl = "https://api.fonofy.in/api/common/";
//   static const String stateEndPoint = "${baseUrl}location-list";
//   static const String cityEndPoint = "${baseUrl}location-list?stateId=";
//
//   // Fetch States
//   Future<List<LocationModel>> fetchLocations() async {
//     final response = await http.get(Uri.parse(stateEndPoint));
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((json) => LocationModel.fromJson(json)).toList();
//     } else {
//       throw Exception("Failed to load states");
//     }
//   }
//
//   // Fetch Cities Based on Selected State
//   Future<List<CityModel>> fetchCities(int stateId) async {
//     final response = await http.get(Uri.parse("$cityEndPoint$stateId"));
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       print("🔍 City API Response: $data"); // ✅ Debugging log
//       return data.map((json) => CityModel.fromJson(json)).toList();
//     } else {
//       throw Exception("Failed to load cities");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/CityModel.dart';
import '../model/LocationModel.dart';

class LocationService {
  static const String baseUrl = "https://api.fonofy.in/api/common/";
  static const String stateEndPoint = "${baseUrl}location-list";
  static const String cityEndPoint = "${baseUrl}city-list?stateid=";

  // Fetch States
  Future<List<LocationModel>> fetchLocations() async {
    final response = await http.get(Uri.parse(stateEndPoint));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("🌍 States API Response: $data");
      return data.map((json) => LocationModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load states");
    }
  }
  // Fetch Cities Based on Selected State
  Future<List<CityModel>> fetchCities(int stateId) async {
    final response = await http.get(Uri.parse("$cityEndPoint$stateId"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("🏙️ Cities API Response for stateId $stateId: $data");
      return data.map((json) => CityModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load cities");
    }
  }
}
