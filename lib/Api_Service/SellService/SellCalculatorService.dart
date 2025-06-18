import 'dart:convert';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:http/http.dart' as http;
import 'package:fonofy/Services/web_constants.dart';
import '../../model/SellCalculationModel.dart';

class SellCalculatorService {

  Future<PriceEvaluation> calculateSellPrice({
    required List<double> questWeights,
    required double basePrice,
  }) async {


    final token = await TokenHelper.getToken();
    print("Fetched token: $token");

    final url = Uri.parse("$baseurl$b2c$sellCalculator");

    var request = http.Request('POST', Uri.parse(url.toString()));

    var reqData = {
      "QuestWeghtes": questWeights,
      "baseprice": basePrice,
    };
    request.body = jsonEncode(reqData);

    var header = {
      'Content-Type': 'application/json',
       'Authorization': 'Bearer $token',
    };

    request.headers.addAll(header);

    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
      print("cdcc "+ data.toString());
     if (response.statusCode == 200) {
      return PriceEvaluation.fromJson(data);
    } else {
      return PriceEvaluation.fromJson(data);
    }
  }
}
