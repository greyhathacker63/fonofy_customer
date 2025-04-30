import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/AddToCartModel/DeleteCartResponseModel.dart';
import '../BaseUrl/AllBaseUrl.dart';

class DeleteCartService {
  static Future<DeleteCartResponseModel?> deleteCartItem({
    required String modelNo,
    required String ramId,
    required String romId,
    required String customerId,
  }) async {
    try {
      final url = Uri.parse(
        '$deleteCartUrl?ModelNo=$modelNo&Ramid=$ramId&Romid=$romId&CustomerId=$customerId',
      );

      final response = await http.delete(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return DeleteCartResponseModel.fromJson(jsonData);
      } else {
        print('❌ Failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ DeleteCartService Error: $e');
      return null;
    }
  }
}
