
import 'package:flutter/material.dart';
import 'package:fonofy/Cart_Screens/CartScreen.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductRamRomColorListModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductReviewModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import '../Api_Service/AddToCartService/AddToCartService.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../Api_Service/ProductDetailsService/ProductImageListService.dart';
import '../Api_Service/ProductDetailsService/ProductRatingService.dart';
import '../Api_Service/ProductDetailsService/ProductReviewService.dart';
import '../Bottom_Sheet/ProductAttributeBottomSheet.dart';
import '../TokenHelper/TokenHelper.dart';
import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';
import '../controllers/ControllerProductDetails/ControllerProductList.dart';
import '../model/DataObject.dart';
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

  List<ProductDetailsListModel> productDetailsList =[];
  List <AddToCartModel> productAddToCart = [];
  List<ProductReviewModel> reviews = [];
  List<ProductImageListModel> productImages = [];

  ProductRatingModel? ratingData;

  AddToCartModel? addToaCrtData;


  int selectedImageIndex = 0;
  int totalRatings = 0;

  // final String colorRom = "";
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
      final productImageList = await ProductImageListService.fetchProductImagesList(
        refNo: widget.refNo,
        url: widget.url,
      );
      setState(() {
        productImages = productImageList;
        // DataClass.imageUrl = productImages[0].image.toString();
        isLoading = false;
      });
    } catch (e) {
      print("Error loading images: $e");
      setState(() => isLoading = false);
    }
  }
  final ControllerProductDetailsList controllerProductDetailsList = Get.put(ControllerProductDetailsList());
  @override
  void initState() {
    super.initState();
    controllerProductDetails.getProductDetailsData(url: widget.url, refNo: widget.refNo);
    controllerProductDetailsList.getProductListData();
    loadProductRating();
    loadProductReview();
    fetchImagesList();
  }

  // Future<void> fetchImages() async {
  //   try {
  //     final images = await ProductImageListService.fetchProductImagesList(
  //       refNo: widget.refNo,
  //       url: widget.url,
  //     );
  //     setState(() {
  //       productImages = images;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print("Error loading images: $e");
  //     setState(() => isLoading = false);
  //   }
  // }
  // final List<String> productImages = [
  //   "assets/images/main_product.png",
  //   "assets/images/thumb_1.png",
  //   "assets/images/thumb_2.png",
  //   "assets/images/thumb_3.png",
  //   "assets/images/thumb_4.png",
  // ];
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
              return Center(
                // child: CircularProgressIndicator(
                //   color: Colors.blue,
                //   strokeWidth: 1,
                // ),
              );
            }
             return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;  // Toggle the state
                });
              },
            );
          }),
        ],
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
                      : CircularProgressIndicator(strokeWidth: 1,color: Colors.blue,), // Show loading indicator while the images are being fetched
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
                SizedBox(height: 15),
                Text(
                  "( ${product.productAndModelName ?? ''} )  ${product.ramName ?? ''}/${product.romName ?? ''}",
                  // "( ${ product.modelUrl ?? ''}) Redmi 6 Pro Max (Champagne Gold, 6GB RAM, 128GB Storage) - 64MP Quad...",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Text("Display( ${product.display ?? ''} ",
                  style: TextStyle(
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
                // _buildRecommendedProducts(productDetailsList:controllerProductDetailsList.productDetailsList),
                const SizedBox(height: 20),
                _buildFeatureSection(),
                const SizedBox(height: 20),
                buildPincodeSection(),
                const SizedBox(height: 20),
                buildUserReviewsSection(product,reviews),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }
  Widget _buildBottomButtons() {
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
                    Get.to(() => LoginScreen());
                    return;
                  }
                  final addToCartService = AddToCartService();
                  final response = await addToCartService.fetchAddToCartData(
                    userCode,
                    product?.ramId,
                    product?.romId,
                    product?.stockQuantity,
                    product?.colorId,
                    product?.modelNo,
                  );
                  if (response != null) {
                    Get.to(() => CartScreen());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Something went wrong! Please try again."),
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
              child: const Text("ADD TO CART",
                style: TextStyle(color: Colors.black,fontSize: 15),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("BUY NOW", style: TextStyle(color: Colors.white)),
              )),
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
              itemCount:  productDetailsList?.length ?? 0,
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

}

