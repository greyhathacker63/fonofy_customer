import 'package:get/get.dart';
import 'package:fonofy/Api_Service/FilterService/FiltersGetAllProductListService.dart';
import 'package:fonofy/model/FiltersModel/FiltersGetAllProductListModel.dart';

class FiltersGetAllProductController extends GetxController {
  var isLoading = false.obs;
  RxList<FiltersGetAllProductListModel>

   filtersGetProductList = <FiltersGetAllProductListModel>[].obs;

  // Fetch products with given filters
  Future<void> fetchGetAllProduct({
    required String ram,
    required String rom,
    required String brand,
    required String color,
    required String display,
    required String battery,
    required String front,
    required String processor,
    required String rear,
    required String category,
    required String productpage,
  }) async {
    try {
      isLoading.value = true;

      final List<FiltersGetAllProductListModel> result = (await FiltersGetAllProductService.fetchFilteredProducts(
        ram: ram,
        rom: rom,
        brand: brand,
        color: color,
        display: display,
        battery: battery,
        front: front,
        processor: processor,
        rear: rear,
        category: category,
        productpage: productpage,
      )) as List<FiltersGetAllProductListModel>;

      filtersGetProductList.value = result;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
