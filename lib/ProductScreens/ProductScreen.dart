import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/Filters/CompareScreen.dart';
import 'package:fonofy/Filters/FilterScreen.dart';
import 'package:fonofy/utils/Colors.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../Bottom_Sheet/SortBy..dart';
import '../Wishlist/WishlistScreen.dart';
import '../controllers/ControllerProductDetails/ControllerProductList.dart';
import '../model/ProductDetailsModel/GetSearchProductsModel.dart';
import '../model/ProductDetailsModel/SearchCompareProductModel.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String sortBy = "None";
  List<SearchCompareProductModel> selectedProducts = [];
  bool showCheckboxes = false;

  List<SearchCompareProductModel> productsList = [
    SearchCompareProductModel(
      name: 'Samsung Galaxy M35 5G \n (Thunder Grey, 6GB RAM, 128GB Storage)',
      amount: "14999",
      url: '',
      image: 'assets/images/Phone3.png',
    ),
    SearchCompareProductModel(
      name: 'Samsung Galaxy M35 5G \n (Daybreak Blue, 8GB RAM, 256GB Storage)',
      amount: '19999',
      url: '',
      image: 'assets/images/thumb_3.png',
    ),
    SearchCompareProductModel(
      name: 'OnePlus Nord CE 3 Lite 5G \n (Pastel Lime, 8GB RAM, 128GB Storage)',
      amount: '15656',
      url: '',
      image: 'assets/images/thumb_2.png',
    ),
    SearchCompareProductModel(
      name: 'realme NARZO 70 Turbo 5G  \n (Turbo Yellow, 6GB RAM, 128GB Storage)',
      amount: '16998',
      url: '',
      image: 'assets/images/main_product.png',
    ),
  ];

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.white,
      ),
      body: Column(
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
                    onPressed: () {
                      Get.to(() => FilterScreen());
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
                    icon: const Icon(Icons.compare_arrows,
                        color: Colors.black),
                    label: const Text("Compare",
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                final product = productsList[index];
                final isSelected = selectedProducts.contains(product);
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
                          child: product.image != null &&
                              product.image!.startsWith('assets/')
                              ? Image.asset(
                            product.image!,
                            fit: BoxFit.contain,
                          )
                              : Image.network(
                            '${imageAllBaseUrl}${product.image ?? ""}',
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
                                product.name ?? '',
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
                                      onTap: () {
                                        Get.to(() =>
                                            WishlistScreen());
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
                                        child: const Icon(Icons.favorite_border,
                                            size: 24, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.snackbar(
                                        "Added to Cart",
                                        "${product.name} added successfully!",
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
                                          toggleSelection(product),
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
      ),
    );
  }
}
