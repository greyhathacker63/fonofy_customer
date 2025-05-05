// product_controller.dart
import 'dart:developer';

import 'package:get/get.dart';
import 'package:fonofy/model/ProductModel.dart';
import 'package:fonofy/Api_Service/search_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productsList = <ProductModel>[].obs;
  var selectedProducts = <ProductModel>[].obs;

  Future<void> fetchProducts({
    String? category,
    String? productpage,
    String? customerId,
    String? ramUrl,
    String? romUrl,
    String? minPrice,
    String? maxPrice,
    String? pageCount,
    String? ramName,
  }) async {
    try {
      isLoading(true);
      productsList.clear();

      final products = await SearchService.fetchAllProducts(
        category: category,
        productpage: productpage,
        customerId: customerId,
        maxPrice: maxPrice,
        ramName: ramName,
        // Only pass parameters that have values
      );
      
      productsList.assignAll(products);
    } catch (e) {
      log("Error in fetchProducts: $e");
      // You might want to show an error message to the user here
      rethrow;
    } finally {
      isLoading(false);
    }
  }
  void toggleSelection(ProductModel product) {
    if (selectedProducts.contains(product)) {
      selectedProducts.remove(product);
    } else {
      selectedProducts.add(product);
    }
  }
}