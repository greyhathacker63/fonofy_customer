// product_controller.dart
import 'package:get/get.dart';
import 'package:fonofy/model/ProductModel.dart';
import 'package:fonofy/Api_Service/search_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productsList = <ProductModel>[].obs;
  var selectedProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Fetch products using SearchService
  Future<void> fetchProducts({
    String? category,
    String? productpage,
    String? customerId,
    String? ramUrl,
    String? romUrl,
    String? minPrice,
    String? maxPrice,
    String? pageCount,
  }) async {
    try {
      isLoading(true); // Set loading to true before fetching data
      productsList
          .clear(); // Clear existing products in the list before fetching new ones

      final products = await SearchService.fetchAllProducts(
        category: category,
        productpage: productpage,
        customerId: customerId,
        ramUrl: '',
        romUrl: '',
        minPrice: '',
        maxPrice: '',
        pageCount: '',
      );
      productsList.assignAll(products);
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
