import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fonofy/model/ProductModel.dart';
import '../../../model/common_filter_model.dart';
import '../../../Api_Service/FilterService/FilterService.dart';
import 'package:fonofy/Services/web_constants.dart' as WebConstants; // 👈 FIXED here

class FilterController extends ChangeNotifier {
  CommonFilterModel? commonFilters;

  // Selected filter values
  Map<String, dynamic> selectedFilters = {
    "Price": {"min": "", "max": ""},
    "RAM": <String>{},
    "ROM": <String>{},
    "Display": <String>{},
    "Battery": <String>{},
    "Front Camera": <String>{},
    "Rear Camera": <String>{},
    "Processor": <String>{},
    "Color": <String>{},
    "Brand": <String>{},
  };

  late String apiUrl;

  // Price controllers
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  List<ProductModel> productList = [];

  final filterService = FilterService();

  // Fetch dropdown filters
  Future<void> fetchCommonFilters() async {
    final data = await filterService.fetchCommonFilterData();
    if (data != null) {
      commonFilters = data;
      notifyListeners();
    }
  }

  void toggleSelection(String category, String value) {
    final currentSet = selectedFilters[category] as Set<String>;
    if (currentSet.contains(value)) {
      currentSet.remove(value);
    } else {
      currentSet.add(value);
    }
    notifyListeners();
  }

  void clearFilters() {
    selectedFilters.forEach((key, value) {
      if (key == "Price") {
        selectedFilters[key]["min"] = "";
        selectedFilters[key]["max"] = "";
        minPriceController.clear();
        maxPriceController.clear();
      } else {
        (selectedFilters[key] as Set).clear();
      }
    });
    notifyListeners();
  }

  // Filter API POST call
  Future<void> fetchFilteredProducts() async {
    apiUrl = WebConstants.baseurl + WebConstants.common + WebConstants.productList;

    final uri = Uri.parse(apiUrl);

    final body = {
      "min_price": selectedFilters["Price"]["min"],
      "max_price": selectedFilters["Price"]["max"],
      "ram": (selectedFilters["RAM"] as Set).toList(),
      "rom": (selectedFilters["ROM"] as Set).toList(),
      "display": (selectedFilters["Display"] as Set).toList(),
      "battery": (selectedFilters["Battery"] as Set).toList(),
      "front_camera": (selectedFilters["Front Camera"] as Set).toList(),
      "rear_camera": (selectedFilters["Rear Camera"] as Set).toList(),
      "processor": (selectedFilters["Processor"] as Set).toList(),
      "color": (selectedFilters["Color"] as Set).toList(),
      "brand": (selectedFilters["Brand"] as Set).toList(),
    };

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        productList = (json['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
        notifyListeners();
      } else {
        print("Error fetching filtered products: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
