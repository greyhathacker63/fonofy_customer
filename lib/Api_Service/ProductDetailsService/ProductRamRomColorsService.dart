import 'dart:convert';

import 'package:fonofy/Api_Service/BaseUrl/AllBaseUrl.dart';
import 'package:fonofy/models/ProductRamRomColorListModel/ProductRamRomColorListModel.dart';
import 'package:http/http.dart' as http;

import '../../services/web_constants.dart';

class ProductRamRomColorsService{

  Future<List<ProductRamRomColorListModel>> fetchProductRamRomListColorsData(String url,String rdfNo) async{
    try {
      var url = Uri.parse(productListColorUrl);
      final Map<String, dynamic> requestBody = {
          "Url": "$url",
          "Pid": 0,
          "Refno": "$rdfNo",
          "Method": "",
          "CustomerId": "",
          "Ram": "",
          "Rom": "",
          "Color": "",
          "Price": ""
      };
      var response = await http.post(url, headers: headers,
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        if (decodedResponse is List) {
          return decodedResponse.map((item) => ProductRamRomColorListModel.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}