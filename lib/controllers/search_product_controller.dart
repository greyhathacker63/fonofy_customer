import 'package:fonofy/Api_Service/search_product/search_product_service.dart';
import 'package:get/get.dart';
import 'package:fonofy/models/SearchProductModel/SearchProductModel.dart';


class SearchProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <SearchProductModel>[].obs;

  Future<void> fetchSearchProducts(String query) async {
    isLoading.value = true;
    try {
      final products = await SearchService.fetchSearchProducts(query);
      productList.assignAll(products);
    } catch (e) {
      productList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
