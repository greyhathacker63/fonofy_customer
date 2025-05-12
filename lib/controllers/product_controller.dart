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
  String? WishlistId,
}) async {
  try {
    isLoading(true);
    productsList.clear();

    final products = await SearchService.fetchAllProducts(
      category: category,
      productpage: productpage,
      customerId: customerId,
      ramUrl: ramUrl,
      romUrl: romUrl,
      minPrice: minPrice,
      maxPrice: maxPrice,
      pageCount: pageCount,
      ramName: ramName,
    
    );

    productsList.assignAll(products);
  } catch (e) {
    log("Error in fetchProducts: $e");
    rethrow;
  } finally {
    isLoading(false);
  }
}

}