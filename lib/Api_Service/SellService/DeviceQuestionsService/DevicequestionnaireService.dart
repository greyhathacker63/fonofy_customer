import 'dart:convert';
import 'package:fonofy/model/SellDevice/DeviceQuestions.dart';
import 'package:http/http.dart' as http;

class SellQuestionService {
  static const String _baseUrl =
      'https://api.fonofy.in/api/common/sell-question-list';

  // Future<SellQuestion?> fetchSellQuestions({
  //   required int bid,
  //   required int pid,
  //   required int raid,
  //   required int  roid,
  //   required String model,
  //   required String ram,
  //   required String rom,
  //   required String basePrice,
  // }) async {
  //   final uri = Uri.parse('$_baseUrl?bid=$bid&pid=$pid&raid=$raid&roid=$roid&model=$model&ram=${ram.toString().trim()}&rom=$rom&baseprice=$basePrice');
  //   print(uri.toString());
  //   try {
  //     final response = await http.get(uri);

  //     if (response.statusCode == 200) {
  //       final jsonBody = json.decode(response.body);
  //       return SellQuestion.fromJson(jsonBody);
  //     } else {
  //       print('Failed to load data. Status code: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching sell questions: $e');
  //     return null;
  //   }
  // }

  /*-------Customer Login-------*/
  Future<SellQuestion> fetchSellQuestions({
    required int bid,
    required int pid,
    required int raid,
    required int roid,
    required String model,
    required String ram,
    required String rom,
    required String basePrice,
  }) async {
    final uri = Uri.parse(
        '$_baseUrl?bid=$bid&pid=$pid&raid=$raid&roid=$roid&model=$model&ram=${ram.toString().trim()}&rom=$rom&baseprice=$basePrice');
    print(uri.toString());

    var request = http.Request('GET', uri);
    // print(request);
    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    // print(response.statusCode.toString());
    // log(data.toString());

    if (response.statusCode == 200) {
      return SellQuestion.fromJson(data);
    } else {
      return SellQuestion.fromJson(data);
    }
  }
}
