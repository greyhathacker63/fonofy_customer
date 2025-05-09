import 'dart:convert';
import 'package:fonofy/Services/web_constants.dart';
import 'package:http/http.dart' as http;

import '../../model/common_filter_model.dart';

class FilterService {
  Future<CommonFilterModel?> fetchCommonFilterData() async {
    try {
      final String url = "$baseurl$common$filter";
      print("Fetching filters from: $url");

      final response = await http.get(Uri.parse(url));
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return CommonFilterModel.fromJson(jsonData);
      } else {
        print("Failed to load filters. Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return null;
    }
  }
}
