import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/AddToCartService/AddToBuyNowService.dart';
import 'package:fonofy/Cart_Screens/CartScreen.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:fonofy/controllers/product_controller.dart';
import 'package:fonofy/controllers/wishlist_controller.dart';
import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductRamRomColorListModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductReviewModel.dart';
import 'package:get/get.dart';
import '../Api_Service/AddToCartService/AddToCartService.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../Api_Service/ProductDetailsService/ProductImageListService.dart';
import '../Api_Service/ProductDetailsService/ProductRatingService.dart';
import '../Api_Service/ProductDetailsService/ProductReviewService.dart';
import '../Bottom_Sheet/ProductAttributeBottomSheet.dart';
import '../Cart_Screens/CheckoutScreen.dart';
import '../TokenHelper/TokenHelper.dart';
import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';
import '../controllers/ControllerProductDetails/ControllerProductList.dart';
import '../model/ProductDetailsModel/ProductDetailsListModel.dart';
import '../model/ProductDetailsModel/ProductDetailsModel.dart';
import '../model/ProductDetailsModel/ProductImageListModel.dart';
import '../model/ProductDetailsModel/ProductRatingModel.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildPincodeSection.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildPricingCard.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildProductAttributesCard.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildProductHighlightsCard.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildUserReviewsSection.dart';

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
      _ProductDetailsScreenState();
}
class _ProductDetailsScreenState extends State<BuyRefurbishedProductScreen> {

  final ControllerProductDetails controllerProductDetails = Get.put(ControllerProductDetails());

  List<ProductDetailsListModel> productDetailsList = [];
  List<AddToCartModel> productAddToCart = [];
  List<ProductReviewModel> reviews = [];
  List<ProductImageListModel> productImages = [];

  Set<String> wishlistedProductNames = {};
  final ProductController productController = Get.put(ProductController());
  final WishlistController wishlistController = Get.put(WishlistController());

  ProductRatingModel? ratingData;

  AddToCartModel? addToaCrtData;

  int selectedImageIndex = 0;
  int totalRatings = 0;

  bool isFavorite = false;
  bool favoriteClicked = false;
  bool isLoading = true;
  dynamic price;

  Future<void> loadProductRating() async {
    final data = await ProductRatingService.fetchProductRating(widget.url);
    if (data != null) {
      setState(() {
        ratingData = data;
        totalRatings = (data.rating1 ?? 0) +
            (data.rating2 ?? 0) +
            (data.rating3 ?? 0) +
            (data.rating4 ?? 0) +
            (data.rating5 ?? 0);
      });
    }
  }

  Future<void> loadProductReview() async {
    final response = await ProductReviewService.fetchProductReviews(widget.url);
    if (response != null) {
      setState(() {
        reviews = response;
      });
    }
  }

  Future<void> fetchImagesList() async {
    try {
      final productImageList =
          await ProductImageListService.fetchProductImagesList(
        refNo: widget.refNo,
        url: widget.url,
      );
      setState(() {
        productImages = productImageList;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading images: $e");
      setState(() => isLoading = false);
    }
  }

  final ControllerProductDetailsList controllerProductDetailsList =
      Get.put(ControllerProductDetailsList());

  @override
  void initState() {
    super.initState();
    controllerProductDetails.getProductDetailsData(
        url: widget.url, refNo: widget.refNo);
    controllerProductDetailsList.getProductListData();
    loadProductRating();
    loadProductReview();
    fetchImagesList();
  }

  final List<Map<String, String>> features = [
    {"icon": "assets/images/warranty.png", "text": "6-Month Warranty"},
    {"icon": "assets/images/exchange.png", "text": "3-Days Exchange"},
    {"icon": "assets/images/shipping.png", "text": "Free Shipping"},
    {"icon": "assets/images/emi.png", "text": "Easy No Cost EMIs"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Obx(() {
          var product = controllerProductDetails.productDetails.value;
          if (product == null) {
            return const Text("");
          }
          return Text(
            '${product.productAndModelName.toString() ?? ''} - ${product.ramName.toString() ?? ''}/ ${product.romName.toString() ?? ''}',
            style: const TextStyle(color: Colors.black, fontSize: 14),
          );
        }),
        centerTitle: true,
        actions: [
          Obx(() {
            var product = controllerProductDetails.productDetails.value;
            if (product == null) {
              return const SizedBox.shrink();
            }

            return IconButton(
              icon: Icon(
                product.wishlistCount == 1
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: product.wishlistCount == 1 ? Colors.red : Colors.grey,
              ),
              onPressed: () async {
                final userCode = await TokenHelper.getUserCode();

                if (userCode == null || userCode.isEmpty) {
                  Get.snackbar(
                    "Login Required",
                    "Please login to wishlist a product",
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  Get.to(() => LoginScreen());
                  return;
                }

                if (product.wishlistCount == 0) {
                  // Add to wishlist
                  wishlistController.addProductToWishlist(
                    productId: product.modelNo.toString(),
                    colorId: product.colorId.toString(),
                    ramId: product.ramId.toString(),
                    romId: product.romId.toString(),
                  );
                  product.wishlistCount = 1;
                  Get.snackbar("Wishlist", "Product added to wishlist",
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  // Remove from wishlist
                  wishlistController.removeFromWishlist(
                    wishlistId: product.wishlistId.toString(),
                    modelId: product.modelNo.toString(),
                    colorId: product.colorId.toString(),
                    ramId: product.ramId.toString(),
                    romId: product.romId.toString(),
                  );
                  product.wishlistCount = 0;
                  Get.snackbar("Wishlist", "Product removed from wishlist",
                      snackPosition: SnackPosition.BOTTOM);
                }

                // ✅ Trigger UI rebuild properly
                controllerProductDetails.productDetails.value =
                    controllerProductDetails.productDetails.value!;
              },
            );
          })
        ],

        //       actions: [
        //         Obx(() {
        //           var product = controllerProductDetails.productDetails.value;
        //           if (product == null) {
        //             return const SizedBox.shrink();
        //           }
        //           // return IconButton(
        //           //   icon: Icon(
        //           //     isFavorite ? Icons.favorite : Icons.favorite_border,
        //           //     color: Colors.red,
        //           //   ),
        //           //   onPressed: () {
        //           //     setState(() {

        //           //       isFavorite = !isFavorite;
        //           //     });
        //           //   },
        //           // );
        //           IconButton(
        //                itemCount: productController.productsList.length,
        //               itemBuilder: (context, index) {
        //                 final product = productController.productsList[index];
        // icon: Icon(
        //   productController.productsList[index].wishlistCount == 1
        //       ? Icons.favorite
        //       : Icons.favorite_border,
        //   color: productController.productsList[index].wishlistCount == 1
        //       ? Colors.red
        //       : Colors.grey,
        // ),
        // onPressed: () async {
        //   final userCode = await TokenHelper.getUserCode();

        //   if (userCode == null || userCode.isEmpty) {
        //     Get.snackbar(
        //       "Login Required",
        //       "Please login to wishlist a product",
        //       snackPosition: SnackPosition.BOTTOM,
        //     );
        //     Get.to(() => LoginScreen());
        //     return;
        //   }

        //   final product = productController.productsList[index];

        //   if (product.wishlistCount == 0) {
        //     // ADD to wishlist
        //     wishlistController.addProductToWishlist(
        //       productId: product.modelNo.toString(),
        //       colorId: product.colorId.toString(),
        //       ramId: product.ramId.toString(),
        //       romId: product.romId.toString(),
        //     );

        //     setState(() {
        //       product.wishlistCount = 1;
        //     });

        //     Get.snackbar("Wishlist", "Product added to wishlist",
        //         snackPosition: SnackPosition.BOTTOM);
        //   } else {
        //     // REMOVE from wishlist
        //     wishlistController.removeFromWishlist(
        //       wishlistId: product.id.toString(), // Must be stored in model
        //       modelId: product.modelNo.toString(),
        //       colorId: product.colorId.toString(),
        //       ramId: product.ramId.toString(),
        //       romId: product.romId.toString(),
        //     );

        //     setState(() {
        //       product.wishlistCount = 0;
        //     });

        //     Get.snackbar("Wishlist", "Product removed from wishlist",
        //         snackPosition: SnackPosition.BOTTOM);
        //   }
        // };

        //               }
        //           );

        //         }),
      ),
      body: Obx(() {
        var product = controllerProductDetails.productDetails.value;
        price = product?.sellingPrice.toString();
        if (product == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: productImages.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            "$imageAllBaseUrl${productImages[selectedImageIndex].image ?? ''}",
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        )
                      : const CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.blue,
                        ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImageIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedImageIndex == index
                                  ? Colors.black26
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            "${imageAllBaseUrl}${productImages[index].image ?? ''}",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "( ${product.productAndModelName ?? ''} )  ${product.ramName ?? ''}/${product.romName ?? ''}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Text(
                  "Display( ${product.display ?? ''} ",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                buildPricingCard(product),
                const SizedBox(height: 15),
                buildProductAttributesCard(context, product),
                const SizedBox(height: 20),
                buildProductHighlightsCard(product),
                const SizedBox(height: 20),
                _buildRecommendedProducts(product),
                const SizedBox(height: 20),
                _buildFeatureSection(),
                const SizedBox(height: 20),
                buildPincodeSection(),
                const SizedBox(height: 20),
                buildUserReviewsSection(product, reviews),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomButtons(productImages),
    );
  }

  Widget _buildBottomButtons(List<ProductImageListModel> productImages) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () async {
                try {
                  final product = controllerProductDetails.productDetails.value;
                  final userCode = await TokenHelper.getUserCode();
                  if (userCode == null) {
                    Get.to(() => const LoginScreen());
                    return;
                  }
                  final addToCartService = AddToCartService();
                  final response = await addToCartService.fetchAddToCartData(
                    userCode,
                    product?.ramId?.toString(),
                    product?.romId?.toString(),
                    product?.stockQuantity?.toString(),
                    product?.colorId?.toString(),
                    product?.modelNo?.toString(),
                  );
                  if (response != null) {
                    Get.to(() => const CartScreen());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Something went wrong! Please try again."),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                } catch (e) {
                  print("Add to Cart Error: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("An error occurred: $e"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: const Text(
                "ADD TO CART",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final product = controllerProductDetails.productDetails.value;
                  final userCode = await TokenHelper.getUserCode();
                  if (userCode == null) {
                    Get.to(() => const LoginScreen());
                    return;
                  }
                  if (product == null || productImages.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product details not available!"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  Get.to(() => CheckoutScreen(
                        isSingleProduct: true,
                        modelNo: product.modelNo?.toString() ?? '',
                        colorId: product.colorId?.toString() ?? '',
                        stockQuantity: product.stockQuantity?.toString() ?? '1',
                        price: product.sellingPrice?.toDouble() ?? 0.0,
                        productImage: productImages[0].image ?? '',
                        userCode: userCode,
                        productName: product.productAndModelName ?? '',
                        ramName: product.ramName ?? '',
                        romName: product.romName ?? '',
                        colorName: product.colorName ?? '',
                        ramId: product.ramId?.toString() ?? '',
                        romId: product.romId?.toString() ?? '',
                        newModelAmt: product.newModelAmt?.toDouble() ?? 0.0,
                      ));
                } catch (e) {
                  print("Buy Now Error: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("An error occurred: $e"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("BUY NOW",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedProducts(ProductDetailsModel product) {
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
              itemCount: productDetailsList.length,
              itemBuilder: (context, index) {
                final product = productDetailsList[index];
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
                                  '${imageAllBaseUrl}${product.image ?? ''}',
                                  height: 55,
                                  width: 55,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                product.productAndModelName ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Ram       ${product.ramName ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rom       ${product.romName ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Color      ${product.colorName ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "₹${product.amount?.toString() ?? '0'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      "₹${product.newModelAmt?.toString() ?? '0'}",
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
                        Positioned(
                          top: 1,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              '${product.discountPercentage?.toString() ?? ''}%',
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
            Image.asset(
              feature["icon"]!,
              height: 40,
            ),
            const SizedBox(height: 5),
            Text(
              feature["text"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
    );
  }
}
