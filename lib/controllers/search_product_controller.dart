import 'package:fonofy/Api_Service/search_product/search_product_service.dart';
import 'package:get/get.dart';
import 'package:fonofy/model/search_product_model.dart';


class SearchProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <SearchProduct>[].obs;

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
