
import 'package:get/get.dart';
import '../../Api_Service/ProductDetailsService/SearchProductService.dart';
import '../../models/SearchCompareProductModel/SearchCompareProductModel.dart';

class SearchCompareController extends GetxController {
  var productSearchList = <SearchCompareProductModel>[].obs;
  var isLoading = false.obs;

  Future<void> searchProducts(String query) async {
    try {
      isLoading.value = true;
      final results = await SearchProductService.fetchSearchProductsList(query);
      productSearchList.value = results;
    } finally {
      isLoading.value = false;
    }
  }
}
