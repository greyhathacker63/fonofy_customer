import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/DeleteCartResponseModel/DeleteCartResponseModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

class DeleteCartService {
  static Future<String> deleteCartItem({
    required String modelNo,
    required String ramId,
    required String romId,
    required String customerId,
  }) async {
    try {
      final url = Uri.parse(
        '$getDeleteCartUrl?ModelNo=$modelNo&Ramid=$ramId&Romid=$romId&CustomerId=$customerId',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        return "";
      }
    } catch (e) {
      return " ";
    }
  }
}
