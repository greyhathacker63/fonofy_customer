
import 'package:flutter/material.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:fonofy/controllers/product_controller.dart';
import 'package:fonofy/controllers/wishlist_controller.dart';
import 'package:get/get.dart';
import 'package:fonofy/Filters/CompareScreen.dart';
import 'package:fonofy/Filters/FilterScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../Bottom_Sheet/SortBy..dart';
import '../model/ProductDetailsModel/SearchCompareProductModel.dart';

class ProductScreen extends StatefulWidget {
  final String? name;
  final String? productPage;
  final String? ramName;
  final String? maxPrice;
  final String? underAmt;

    const ProductScreen({
    super.key,
    this.name,
    this.productPage,
    this.ramName,
    this.maxPrice,
    this.underAmt,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String sortBy = "None";
  List<SearchCompareProductModel> selectedProducts = [];
  bool showCheckboxes =  false;

  Set<String> wishlistedProductNames = {};

  final ProductController productController = Get.put(ProductController());
  final WishlistController wishlistController = Get.put(WishlistController());

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
  void navigateToCompareScreen(){
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
    loadWishlist();
      productController.isLoading = true.obs;
      productController.fetchProducts(
      category: widget.name,
      productpage: widget.productPage,
      ramName: widget.ramName,
      maxPrice: widget.maxPrice,
    );
  }

  void loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('wishlist') ?? [];
    setState(() {
      wishlistedProductNames = wishlist.toSet();
    });
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
          return const Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
        }

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
                            category: widget.name,
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
                      label:   Text("Compare",
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
                    name: product.productAndModelName,
                     url: product.modelUrl,
                    image: product.image,
                  );
                  final isSelected = selectedProducts.contains(productCompare);
                  wishlistedProductNames
                      .contains(product.productAndModelName);

                  return GestureDetector(
                    onTap: () {
                      final refNo = product.ucode ?? '';
                      final url = product.modelUrl ?? '';

                      if (refNo.isNotEmpty && url.isNotEmpty) {
                        Get.to(() => BuyRefurbishedProductScreen(
                          refNo: refNo,
                          url: url,
                        ));
                      } else {
                        Get.snackbar("Invalid Product",
                            "Missing reference number or URL");
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin:   EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 140,
                              child: (product.image ?? '').startsWith('assets/')
                                  ? Image.asset(product.image!,
                                  fit: BoxFit.contain)
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
                                  return Center(
                                      child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productAndModelName ?? '',
                                    style:   TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${product.ramName ?? 'Ram'} | ${product.romName ?? 'Rom'}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "₹${product.amount ?? ''}",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${product.discountPercentage ?? 0} % Discount',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "₹${product.newModelAmt ?? 'Discounted Amount'}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          product.wishlistCount == 1
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: product.wishlistCount == 1
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () async {
                                          final userCode =
                                          await TokenHelper.getUserCode();
                                          if (userCode == null || userCode.isEmpty) {
                                            Get.snackbar("Login Required", "Please login to wishlist a product",
                                                snackPosition:
                                                SnackPosition.BOTTOM);
                                            Get.to(() => LoginScreen());
                                            return;
                                          }

                                          final isWishlisted = product.wishlistCount == 1;

                                          if (isWishlisted) {
                                            wishlistController.removeFromWishlist(
                                              wishlistId: product.wishlistId.toString(),
                                              modelId: product.modelNo.toString(),
                                              colorId: product.colorId.toString(),
                                              ramId: product.ramId.toString(),
                                              romId: product.romId.toString(),
                                            );
                                          } else {
                                            wishlistController.addProductToWishlist(
                                              productId: product.modelNo.toString(),
                                              colorId: product.colorId.toString(),
                                              ramId: product.ramId.toString(),
                                              romId: product.romId.toString(),
                                            );
                                          }
                                          setState(() {
                                            productController.productsList[index].wishlistCount = isWishlisted ? 0 : 1;
                                          });
                                        },
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.snackbar("Added to Cart",
                                              "${product.productAndModelName} added successfully!",
                                              snackPosition:SnackPosition.BOTTOM);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          ColorConstants.appBlueColor3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text("Add to Cart",
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
                                        Text("Compare",style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
