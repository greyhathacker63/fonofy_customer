import 'dart:convert';
import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/models/AddToCartModel/AddToCartModel.dart';
import 'package:http/http.dart' as http;
import '../../services/web_constants.dart';

class AddToCartService {

  Future<AddToCartModel?> fetchAddToCartData(
      String customerId,
      dynamic ram,
      dynamic rom,
      dynamic qty,
      dynamic color,
      dynamic modelID,
      dynamic price,
      dynamic cartRef,
      ) async {
    try {
      var url = Uri.parse(addToCartUrl);
      final Map<String, dynamic> requestBody = {
        "ProductId": 0,
        "CustomerId": customerId,
        "Quantity": qty,
        "ModelId": modelID,
        "Price": price,
        "BrandId": 0,
        "ColorId": color,
        "RamId": ram,
        "RomId": rom,
        "CartRef": cartRef
      };
      var response = await http.post(url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        return AddToCartModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
