import 'dart:convert';
import 'package:fonofy/services/web_constants.dart';
import 'package:http/http.dart' as http;

import '../../models/CommonFilterModel/CommonFilterModel.dart';

class FilterService {
  Future<CommonFilterModel?> fetchCommonFilterData() async {
    try {
      final String url = "$baseurl$common$filter";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return CommonFilterModel.fromJson(jsonData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
