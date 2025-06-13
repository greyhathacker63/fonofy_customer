import 'dart:convert';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:http/http.dart' as http;


class DeviceQuestionnaireService {
  static Future<DeviceQuestions> fetchDeviceQuestions({
    required int bid,
    required int pid,
    required int raid,
    required int roid,
    required String model,
    required int ram,
    required int rom,
    required int basePrice,
    dynamic weightage,
  }) async {
    final uri = Uri.https('api.fonofy.in', '/api/common/sell-calculator-question-list', {
      'bid': bid.toString(),
      'pid': pid.toString(),
      'raid': raid.toString(),
      'roid': roid.toString(),
      'model': model,
      'ram': ram.toString(),
      'rom': rom.toString(),
      'baseprice': basePrice.toString(),
      'weightage': weightage,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return DeviceQuestions.fromJson(jsonBody);
    } else {
      throw Exception("");
    }
  }
}
