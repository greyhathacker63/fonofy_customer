import 'package:fonofy/Api_Service/FilterService/FiltersGetAllProductListService.dart';
import 'package:fonofy/model/FiltersModel/FiltersGetAllProductListModel.dart';
import 'package:get/get.dart';


class FiltersGetAllProductController extends GetxController {
  var isLoading = false.obs;
  var filtersGetProductList = <FiltersGetAllProductListModel>[].obs;

  Future<void> fetchCompareProducts({
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
    try {
      isLoading.value = true;
      final filtersData  = await FiltersGetAllProductService.fetchFilteredGetAllProducts(
          ram: ram,
          rom: rom,
          brand: brand,
          color: color,
          display: display,
          battery: battery,
          front: front,
          processor: processor,
          rear: rear,
          underAmt: underAmt
      );
      filtersGetProductList.value = filtersData;
    }   finally {
      isLoading.value = false;
    }
  }
}
