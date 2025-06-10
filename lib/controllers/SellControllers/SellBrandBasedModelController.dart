import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/model/SellModel/BrandBasedModel.dart';
import 'package:fonofy/Api_Service/SellService/SellBrandBasedModelService.dart';
import 'package:http/http.dart' as http;

class SellBrandBasedModelController extends GetxController {
  var isSellBrandModelLoading = true.obs;
  var brandResponse = BrandBasedResponse(models: [], series: []).obs;

  List<BrandBasedModel> get models => brandResponse.value.models;
  List<BrandSeries> get series => brandResponse.value.series;

  /// Fetch brand-based models and series (initial call)
  Future<void> getSellBrandModelsData(String brandName) async {
    isSellBrandModelLoading.value = true;
    try {
      brandResponse.value =
          await SellBrandBasedModelService.fetchSellModelsByBrand(brandName);
    } catch (err) {
      print('Brand Model Error: $err');
      Get.snackbar("Error", "Failed to load models: $err",
          backgroundColor: Colors.redAccent);
    } finally {
      isSellBrandModelLoading.value = false;
    }
  }

  /// Fetch data based on selected series (called on tap)
  Future<void> fetchSeriesData(String seriesName) async {
    isSellBrandModelLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.fonofy.in/api/common/brand-based-series?series=${Uri.encodeComponent(seriesName)}'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final List<BrandBasedModel> modelList = (jsonData['Table1'] as List)
            .map((e) => BrandBasedModel.fromJson(e))
            .toList();

        final List<BrandSeries> seriesList = (jsonData['Table'] as List)
            .map((e) => BrandSeries.fromJson(e))
            .toList();

        brandResponse.value = BrandBasedResponse(
          models: modelList,
          series: seriesList,
        );
      } else {
        print("Error fetching series data: ${response.body}");
      }
    } catch (e) {
      print("Exception while fetching series data: $e");
    } finally {
      isSellBrandModelLoading.value = false;
    }
  }
}
