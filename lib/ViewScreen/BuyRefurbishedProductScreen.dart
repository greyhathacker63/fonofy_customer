import 'package:flutter/material.dart';
import 'package:fonofy/controllers/ControllerProductDetails/ControllerProductList.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsListModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductDetailsModel.dart';
import 'package:get/get.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';

class BuyRefurbishedProductScreen extends StatefulWidget {
  final String url;
  final String refNo;
  const BuyRefurbishedProductScreen({
    super.key,
    required this.url,
    required this.refNo,
  });

  @override
  State<BuyRefurbishedProductScreen> createState() =>
      _BuyRefurbishedProductScreenState();
}

class _BuyRefurbishedProductScreenState
    extends State<BuyRefurbishedProductScreen> {
  final ControllerProductDetails controllerProductDetails =
      Get.put(ControllerProductDetails());

  int selectedImageIndex = 0;
  bool isFavorite = false;

  final ControllerProductDetailsList controllerProductDetailsList =
      Get.put(ControllerProductDetailsList());

  final List<String> productImages = [
    "assets/images/main_product.png",
    "assets/images/thumb_1.png",
    "assets/images/thumb_2.png",
    "assets/images/thumb_3.png",
    "assets/images/thumb_4.png",
  ];

  final List<Map<String, String>> features = [
    {"icon": "assets/images/warranty.png", "text": "6-Month Warranty"},
    {"icon": "assets/images/exchange.png", "text": "3-Days Exchange"},
    {"icon": "assets/images/shipping.png", "text": "Free Shipping"},
    {"icon": "assets/images/emi.png", "text": "Easy No Cost EMIs"},
  ];

  @override
  void initState() {
    super.initState();
    controllerProductDetails.getProductDetailsData(
        url: widget.url, refNo: widget.refNo);
    controllerProductDetailsList.getProductListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        var product = controllerProductDetails.productDetails.value;
        if (product == null) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.blue));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildMainImageSection(),
              _buildThumbnailList(),
              _buildTitle(product),
              _buildPricingCard(product),
              const SizedBox(height: 5),
              _buildProductHighlightsCard(product),
              const SizedBox(height: 10),
              _buildRecommendedProducts(
                  productDetailsList:
                      controllerProductDetailsList.productDetailsList),
              const SizedBox(height: 20),
              _buildFeatureSection(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Obx(() {
        var product = controllerProductDetails.productDetails.value;
        if (product == null) return const Text("");
        return Text(
          "${product.productAndModelName ?? ''} ${product.ramName ?? ''}/${product.romName ?? ''}",
          style: const TextStyle(color: Colors.black, fontSize: 14),
        );
      }),
      actions: [
        IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black),
          onPressed: () => setState(() => isFavorite = !isFavorite),
        ),
      ],
    );
  }

  Widget _buildMainImageSection() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(productImages[selectedImageIndex],
            height: 250, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildThumbnailList() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => selectedImageIndex = index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedImageIndex == index
                      ? Colors.black26
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(productImages[index],
                  height: 50, width: 50, fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(ProductDetailsModel product) {
    return Padding(
      padding: const EdgeInsets.only(right: 160, top: 5),
      // child: Text(
      //   "${product.productAndModelName ?? ''} ${product.ramName ?? ''}/${product.romName ?? ''}",
      //   style: const TextStyle(color: Colors.black, fontSize: 12),
      // ),
    );
  }

  Widget _buildPricingCard(ProductDetailsModel product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "( ${product.productAndModelName ?? ''} ${product.ramName ?? ''}/${product.romName ?? ''} )",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("-${product.discountPercentage?.toString() ?? "0"}%",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text("₹${product.sellingPrice?.toString() ?? "0"}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(width: 8),
                Text("₹${product.newModelAmt?.toString() ?? "0"}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                ),

              ],

            ),

            const SizedBox(height: 5),
            const Text("View Plans",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text(
                "Cardless and No Cost EMI Available on credit/debit card",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductHighlightsCard(ProductDetailsModel product) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Highlights",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildProductHighlightRow(
                "Model", product.productAndModelName ?? ""),
            _buildProductHighlightRow("Brand", "Realme"),
            _buildProductHighlightRow("RAM", product.ramName ?? ""),
            _buildProductHighlightRow("ROM", product.romName ?? ""),
            _buildProductHighlightRow("Battery", product.battery ?? ""),
            _buildProductHighlightRow("Color", product.colorName ?? ""),
            _buildProductHighlightRow("OS", "Android"),
            _buildProductHighlightRow("Rear Camera", product.rearCamera ?? ""),
            _buildProductHighlightRow(
                "Front Camera", product.frontCamera ?? ""),
            _buildProductHighlightRow("Display", product.display ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildProductHighlightRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          Text(value,
              style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildRecommendedProducts(
      {List<ProductDetailsListModel>? productDetailsList}) {
    return Obx(() {
      var productList = controllerProductDetailsList.productDetailsList;

      if (controllerProductDetailsList.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (productList.isEmpty) {
        return const Center(child: Text("No recommended products available."));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "You May Also Like",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "View All",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productDetailsList?.length ?? 0,
              itemBuilder: (context, index) {
                final product = productDetailsList?[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  '${imageAllBaseUrl}${product?.image ?? ''}',
                                  height: 55,
                                  width: 55,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                product?.productAndModelName ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Ram       ${product?.ramName ?? ' '}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rom       ${product?.romName ?? ' '}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Color      ${product?.colorName ?? ' '}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "₹${product?.amount?.toString() ?? '0'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      "₹${product?.newModelAmt?.toString() ?? '0'}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Positioned discount badge
                        Positioned(
                          top: 1,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              '${product?.discountPercentage?.toString() ?? ''}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
    });
  }

  Widget _buildFeatureSection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 100,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Column(
          children: [
            Image.asset(feature["icon"]!, height: 40),
            const SizedBox(height: 5),
            Text(feature["text"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          ],
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("ADD TO CART"))),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child:
                  const Text("BUY NOW", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
