import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fonofy/model/FiltersModel/FiltersGetAllProductListModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;

class FiltersGetAllProductService {
  static Future<List<FiltersGetAllProductListModel>> fetchFilteredGetAllProducts({
    required String ram,
    required String rom,
    required String brand,
    required String color,
    required String display,
    required String battery,
    required String front,
    required String processor,
    required String rear,
    required String underAmt,
  }) async {
    final url = Uri.parse('https://api.fonofy.in/api/common/get-all-product-list?'
          'Ramurl=$ram&Romurl=$rom&Brandsurl=$brand&Colorurl=$color'
          '&Displayurl=$display&Batteryurl=$battery&Fronturl=$front'
          '&Processorurl=$processor&Rearurl=$rear&UnderAmt=$underAmt',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);

      Get.snackbar('Success', 'Product list loaded successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return data.map((e) => FiltersGetAllProductListModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load product data");
    }

  }
}
