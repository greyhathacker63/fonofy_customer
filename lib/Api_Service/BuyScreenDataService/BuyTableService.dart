import 'dart:convert';
import 'dart:developer';
 import 'package:http/http.dart' as http;
import '../../services/web_constants.dart';
 import '../../models/ByScreenTableModel/ByScreenTableModel.dart';
import '../BaseUrl/AllBaseUrl.dart';


class BuyTableService {

  static Future<ByTableModel> fetchBuyTableData() async {
    var url = tableUrl ;
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      return ByTableModel.fromJson(data);
    } else {
      return ByTableModel.fromJson(data);
    }
  }
}
