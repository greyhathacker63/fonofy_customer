import 'package:flutter/material.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:fonofy/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:fonofy/Filters/CompareScreen.dart';
import 'package:fonofy/Filters/FilterScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../Bottom_Sheet/SortBy..dart';
import '../Wishlist/WishlistScreen.dart';
import '../model/ProductDetailsModel/GetSearchProductsModel.dart';
import '../model/ProductDetailsModel/SearchCompareProductModel.dart';

class ProductScreen extends StatefulWidget {
  final String? productName;
  final String? productPage;
  final String? ramName;
  final String? maxPrice;
  final String? underAmt;

  const ProductScreen({
    Key? key,
    this.productName,
    this.productPage, this.ramName, this.maxPrice, this.underAmt,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String sortBy = "None";
  List<SearchCompareProductModel> selectedProducts = [];
  bool showCheckboxes = false;

  final ProductController productController = Get.put(ProductController());

  void toggleSelection(SearchCompareProductModel product) {
    setState(() {
      if (selectedProducts.contains(product)) {
        selectedProducts.remove(product);
      } else {
        if (selectedProducts.length < 3) {
          selectedProducts.add(product);
        } else {
          Get.snackbar("Limit Reached", "You can select up to 3 products only",
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    });
  }

  void toggleCompareMode() {
    setState(() {
      showCheckboxes = true;
    });
  }

  void navigateToCompareScreen() {
    if (selectedProducts.length < 2) {
      Get.snackbar("Select More Products",
          "Please select at least 2 products to compare",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.to(() => CompareScreen(selectedProducts: selectedProducts));
  }

  @override
  void initState() {
    super.initState();
    productController.isLoading = true.obs;
    productController.fetchProducts(
      category: widget.productName,
      productpage: widget.productPage,
      ramName: widget.ramName,
      maxPrice: widget.maxPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if the product list is empty
        if (productController.productsList.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        showSortBySheet(context, (selectedSort) {
                          setState(() {
                            sortBy = selectedSort;
                          });
                        });
                      },
                      icon: const Icon(Icons.sort, color: Colors.black),
                      label: const Text("Sort By",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final selectedFilters =
                            await Get.to(() => FilterScreen());

                        if (selectedFilters != null &&
                            selectedFilters is Map<String, dynamic>) {
                          productController.fetchProducts(
                            category: widget.productName,
                            productpage: widget.productPage,
                            ramUrl: selectedFilters['ram'],
                            romUrl: selectedFilters['rom'],
                            minPrice: selectedFilters['minPrice'],
                            maxPrice: selectedFilters['maxPrice'],
                          );
                        }
                      },
                      icon: const Icon(Icons.tune, color: Colors.black),
                      label: const Text("Filter",
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        if (!showCheckboxes) {
                          toggleCompareMode();
                        } else {
                          navigateToCompareScreen();
                        }
                      },
                      icon:
                          const Icon(Icons.compare_arrows, color: Colors.black),
                      label: const Text("Compare",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productController.productsList.length,
                itemBuilder: (context, index) {
                  final product = productController.productsList[index];

                  final productCompare = SearchCompareProductModel(
                    productName: product.productAndModelName,
                    amount: product.amount,
                    modelUrl: product.modelUrl,
                    image: product.image,
                  );

                  final isSelected = selectedProducts.contains(productCompare);

                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 140,
                            child: (product.image ?? '').startsWith('assets/')
                                ? Image.asset(
                                    product.image!,
                                    fit: BoxFit.contain,
                                  )
                                : Image.network(
                                    '$imageAllBaseUrl${product.image ?? ""}',
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2));
                                    },
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productAndModelName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "₹${product.amount ?? ''}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.green),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 37,
                                      child: InkWell(
                                        onTap: () async {
                                          // final userCode =
                                          //     await TokenHelper.getUserCode();
                                          // if (userCode == null ||
                                          //     userCode.isEmpty) {
                                          //   Get.snackbar(
                                          //     "Login Required",
                                          //     "Please login to view your wishlist",
                                          //     snackPosition:
                                          //         SnackPosition.BOTTOM,
                                          //   );
                                          //   Get.to(() => LoginScreen());
                                          // } else {
                                          print("object");
                                            Get.to(() => WishlistScreen());
                                          // }
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                              Icons.favorite_border,
                                              size: 24,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.snackbar(
                                          "Added to Cart",
                                          "${product.productAndModelName} added successfully!",
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConstants.appBlueColor3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text("Add to Cart",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                                if (showCheckboxes)
                                  Column(
                                    children: [
                                      Checkbox(
                                        value: isSelected,
                                        onChanged: (_) =>
                                            toggleSelection(productCompare),
                                      ),
                                      const Text("Compare",
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
