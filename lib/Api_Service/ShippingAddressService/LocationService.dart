
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../model/LocationModel/CityModel.dart';
import '../../model/LocationModel/LocationModel.dart';

class LocationService {
  static const String baseUrl = "https://api.fonofy.in/api/common/";
  static const String stateEndPoint = "${baseUrl}location-list";
  static const String cityEndPoint = "${baseUrl}city-list?stateid=";

  // Fetch States
  Future<List<LocationModel>> fetchLocations() async {
    final url = Uri.parse(stateEndPoint);
    final httpClient = HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final request = await httpClient.getUrl(url);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(responseBody);
      print("🌍 States API Response: $data");
      return data.map((json) => LocationModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load states");
    }
  }


  // Fetch Cities Based on Selected State
  Future<List<CityModel>> fetchCities(int stateId) async {
    final uri = Uri.parse("$cityEndPoint$stateId");
    final url = Uri.parse(stateEndPoint);
    final httpClient = HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final request = await httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(responseBody);
      print("🏙️ Cities API Response for stateId $stateId: $data");
      return data.map((json) => CityModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load cities");
    }
  }
}
