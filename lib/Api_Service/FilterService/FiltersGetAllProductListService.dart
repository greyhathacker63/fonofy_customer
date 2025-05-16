import 'dart:convert';

 import 'package:fonofy/model/FiltersModel/FiltersGetAllProductListModel.dart';
import 'package:http/http.dart' as http;



// class FiltersGetAllProductService {
//   final String baseUrl = 'https://api.fonofy.in/api/common/get-all-product-list';
//
//   static Future<List<FiltersGetAllProductListModel>> fetchFilteredGetAllProducts({
//     required String ram,
//     required String rom,
//     required String brand,
//     required String color,
//     required String display,
//     required String battery,
//     required String front,
//     required String processor,
//     required String rear,
//     required String underAmt,
//   }) async {
//     final url = Uri.parse('https://api.fonofy.in/api/common/get-all-product-list?'
//           'Ramurl=$ram&Romurl=$rom&Brandsurl=$brand&Colorurl=$color'
//           '&Displayurl=$display&Batteryurl=$battery&Fronturl=$front'
//           '&Processorurl=$processor&Rearurl=$rear&UnderAmt=$underAmt',
//     );
//
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//
//       return data.map((e) => FiltersGetAllProductListModel.fromJson(e))
//           .toList();
//     } else {
//       throw Exception("Failed to load product data");
//     }
//   }
//   }
// class FiltersGetAllProductService {
//   static Future<FiltersGetAllProductListModel> fetchFilteredProducts({
//     String? ram,
//     String? rom,
//     String? brand,
//     String? color,
//     String? display,
//     String? battery,
//     String? front,
//     String? processor,
//     String? rear,
//     String? category,
//     String? productpage,
//
//   }) async {
//     final Uri url = Uri.parse("https://api.fonofy.in/api/common/get-all-product-list").replace(
//       queryParameters: {
//         if (ram != null && ram.isNotEmpty) 'Ramurl': ram,
//         if (rom != null && rom.isNotEmpty) 'Romurl': rom,
//         if (brand != null && brand.isNotEmpty) 'Brandsurl': brand,
//         if (color != null && color.isNotEmpty) 'Colorurl': color,
//         if (display != null && display.isNotEmpty) 'Displayurl': display,
//         if (battery != null && battery.isNotEmpty) 'Batteryurl': battery,
//         if (front != null && front.isNotEmpty) 'Fronturl': front,
//         if (processor != null && processor.isNotEmpty) 'Processorurl': processor,
//         if (rear != null && rear.isNotEmpty) 'Rearurl': rear,
//       },
//     );
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       return FiltersGetAllProductListModel.fromJson(jsonData);
//     } else {
//       throw Exception('Failed to fetch products');
//     }
//   }
// }



class FiltersGetAllProductService {
  static Future<FiltersGetAllProductListModel> fetchFilteredProducts({
    String? ram,
    String? rom,
    String? brand,
    String? color,
    String? display,
    String? battery,
    String? front,
    String? processor,
    String? rear,
    String? category,
    String? productpage,
  }) async {
    final Uri url = Uri.parse("https://api.fonofy.in/api/common/get-all-product-list").replace(
      queryParameters: {
        if (ram != null && ram.isNotEmpty) 'Ramurl': ram,
        if (rom != null && rom.isNotEmpty) 'Romurl': rom,
        if (brand != null && brand.isNotEmpty) 'Brandsurl': brand,
        if (color != null && color.isNotEmpty) 'Colorurl': color,
        if (display != null && display.isNotEmpty) 'Displayurl': display,
        if (battery != null && battery.isNotEmpty) 'Batteryurl': battery,
        if (front != null && front.isNotEmpty) 'Fronturl': front,
        if (processor != null && processor.isNotEmpty) 'Processorurl': processor,
        if (rear != null && rear.isNotEmpty) 'Rearurl': rear,
        if (category != null && category.isNotEmpty) 'Category': category,
        if (productpage != null && productpage.isNotEmpty) 'Productpage': productpage,
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return FiltersGetAllProductListModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
