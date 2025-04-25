
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


  int selectedImageIndex = 0;
  int totalRatings = 0;

  final String colorRom = "";

  late bool isFavorite = false;

  bool isLoading = true;

  bool favoriteClicked = false;
  dynamic price;

  ProductRatingModel? ratingData;

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
        DataClass.imageUrl = productImages[0].image.toString();
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
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 1,
                ),
              );
            }
            // Display the favorite button when product is available
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () {
                if (!favoriteClicked) {
                  setState(() {
                    isFavorite = true;
                    favoriteClicked = true;
                  });
                }
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        var product = controllerProductDetails.productDetails.value;
        price = product?.sellingPrice.toString();
        DataClass.modelNo = product?.modelNo.toString();
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
                _buildPricingCard(product),
                const SizedBox(height: 15),
                _buildProductAttributesCard(context, product),
                const SizedBox(height: 20),
                _buildProductHighlightsCard(product),
                const SizedBox(height: 20),
                _buildRecommendedProducts(product),
                // _buildRecommendedProducts(productDetailsList:controllerProductDetailsList.productDetailsList),
                const SizedBox(height: 20),
                _buildFeatureSection(),
                const SizedBox(height: 20),
                _buildPincodeSection(),
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
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {

                DataClass.sellingPrice = price;
                DataClass.productName = widget.url.toString();
                final userCode = await TokenHelper.getUserCode();
                if (userCode == null) {
                   Get.to(() => LoginScreen());
                } else {
                   var response = await AddToCartService.fetchAddToCartData(userCode);
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
                }

              },
              child: const Text("ADD TO CART",style: TextStyle(color: Colors.white)),
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
  Widget _buildPricingCard(ProductDetailsModel product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text("-${product.discountPercentage?.toString() ?? "0"}%",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text("₹${product.sellingPrice ?.toString() ?? "0"}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(width: 8),
                Text(
                  "₹${product.newModelAmt?.toString() ?? "0"}",
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
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    ),
  );
}
Widget _buildProductAttributesCard(BuildContext context, ProductDetailsModel product) {
  String condition = "Fair"; // default fallback
  if(product.romName == "64GB"){
    condition = "Fair";
  }else if(product.romName == "128GB"){
    condition = "Good";
  }else if(product.romName == "256GB"){
    condition = "Super";
  }
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => ProductAttributeBottomSheet(product: product),
      );
    },
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildAttributeRow(
                Icons.phone_android, "Condition", "${condition}", "+1 more"),
            const Divider(),
            _buildAttributeRow(Icons.sd_storage, "Storage",
                "${product.ramName}/ ${product.romName}", "2+ more"),
            const Divider(),
            _buildAttributeRow(
                Icons.circle, "Color", "${product.colorName}", "+2 more",
                isColorDot: true),
          ],
        ),
      ),
    ),
  );
}
Widget _buildAttributeRow(
    IconData icon, String label, String value, String moreText,
    {bool isColorDot = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          if (isColorDot)
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            )
          else
            Icon(icon, size: 20),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(fontSize: 14)),
          Text(value, style:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
      Text(moreText, style: const TextStyle(fontSize: 14, color: Colors.grey)),
    ],
  );
}
Widget _buildPincodeSection() {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter Pincode for Delivery",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Pincode",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle pincode check
                },
                child: const Text("Check"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
Widget buildUserReviewsSection(ProductDetailsModel product, List<ProductReviewModel> reviews) {
  final ratingData = ProductRatingModel();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("User Reviews",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${product.avgReview?.toString() ?? '0.0'}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        final rate = product.avgRate ?? 0.0;

                        if (index < rate.floor()) {
                          return const Icon(Icons.star, color: Colors.orange, size: 18);
                        } else if (index == rate.floor() && rate % 1 >= 0.5) {
                          return const Icon(Icons.star_half, color: Colors.orange, size: 18);
                        } else {
                          return const Icon(Icons.star_border, color: Colors.orange, size: 18);
                        }
                      }),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      "${product.reviewCount ?? 0} reviews",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),

                    const SizedBox(height: 12),

                    Builder(builder: (context) {
                      int totalRatings = (ratingData.rating1 ?? 0) +
                          (ratingData.rating2 ?? 0) +
                          (ratingData.rating3 ?? 0) +
                          (ratingData.rating4 ?? 0) +
                          (ratingData.rating5 ?? 0);

                      final ratingList = [
                        {"star": 5, "count": ratingData.rating5 ?? 0},
                        {"star": 4, "count": ratingData.rating4 ?? 0},
                        {"star": 3, "count": ratingData.rating3 ?? 0},
                        {"star": 2, "count": ratingData.rating2 ?? 0},
                        {"star": 1, "count": ratingData.rating1 ?? 0},
                      ];

                      return Column(
                        children: ratingList.map((rating) {
                          final double value = totalRatings > 0
                              ? (rating["count"] as int) / totalRatings
                              : 0;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Text("${rating["star"]}",
                                    style: const TextStyle(fontSize: 12)),
                                const Icon(Icons.star, size: 14, color: Colors.grey),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: value,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                    minHeight: 6,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text("(${rating["count"]})",
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: 20),
      ListView.builder(
        shrinkWrap: true,
        physics:  NeverScrollableScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final reviewDetails = reviews[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(5, (index) {
                  final rate = product.avgRate ?? 0.0;
                  if (index < rate.floor()) {
                    return const Icon(Icons.star, color: Colors.orange, size: 18);
                  } else if (index == rate.floor() && rate % 1 >= 0.5) {
                    return const Icon(Icons.star_half, color: Colors.orange, size: 18);
                  } else {
                    return const Icon(Icons.star_border, color: Colors.orange, size: 18);
                  }
                }),
              ),

              const SizedBox(height: 8),
              Text(reviewDetails.description.toString(),
                style: TextStyle(fontSize: 12),),
              SizedBox(height: 6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        reviewDetails.firstName ?? '',
                        style:
                        const TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.verified,
                          size: 14, color: Colors.black54),
                    ],
                  ),
                  Text(
                    reviewDetails.createdDate ?? '',
                    style:  TextStyle(color: Colors.grey,fontSize: 13),
                  ),
                ],
              ),
            ],
          );
        },
      )
    ],
  );
}
