// import 'package:flutter/material.dart';
// import 'package:fonofy/Api_Service/AddToCartService/AddToBuyNowService.dart';
// import 'package:fonofy/Cart_Screens/CartScreen.dart';
// import 'package:fonofy/ViewScreen/LoginScreen.dart';
// import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
// import 'package:fonofy/model/AddToCartModel/GetBuynowModel.dart';
// import 'package:fonofy/model/ProductDetailsModel/ProductReviewModel.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';
// import '../Api_Service/AddToCartService/AddToCartService.dart';
// import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
// import '../Api_Service/ProductDetailsService/ProductImageListService.dart';
// import '../Api_Service/ProductDetailsService/ProductRatingService.dart';
// import '../Api_Service/ProductDetailsService/ProductReviewService.dart';
// import '../Cart_Screens/CheckoutScreen.dart';
// import '../TokenHelper/TokenHelper.dart';
// import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';
// import '../controllers/ControllerProductDetails/ControllerProductList.dart';
// import '../model/ProductDetailsModel/ProductDetailsListModel.dart';
// import '../model/ProductDetailsModel/ProductDetailsModel.dart';
// import '../model/ProductDetailsModel/ProductImageListModel.dart';
// import '../model/ProductDetailsModel/ProductRatingModel.dart';
// import '../widgets/BuyRefurbishedProductWidgets/buildPincodeSection.dart';
// import '../widgets/BuyRefurbishedProductWidgets/buildPricingCard.dart';
// import '../widgets/BuyRefurbishedProductWidgets/buildProductAttributesCard.dart';
// import '../widgets/BuyRefurbishedProductWidgets/buildProductHighlightsCard.dart';
// import '../widgets/BuyRefurbishedProductWidgets/buildUserReviewsSection.dart';
//
// class BuyRefurbishedProductScreen extends StatefulWidget {
//   final String url;
//   final String refNo;
//
//   const BuyRefurbishedProductScreen({
//     super.key,
//     required this.url,
//     required this.refNo,
//   });
//
//   @override
//   State<BuyRefurbishedProductScreen> createState() =>
//       _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<BuyRefurbishedProductScreen> {
//   final ControllerProductDetails controllerProductDetails =
//       Get.put(ControllerProductDetails());
//
//   List<ProductDetailsListModel> productDetailsList = [];
//   List<AddToCartModel> productAddToCart = [];
//   List<ProductReviewModel> reviews = [];
//   List<ProductImageListModel> productImages = [];
//
//   ProductRatingModel? ratingData;
//
//   AddToCartModel? addToaCrtData;
//   GetBuyNowModel? getData;
//
//   int selectedImageIndex = 0;
//   int totalRatings = 0;
//
//   bool isFavorite = false;
//   bool favoriteClicked = false;
//   bool isLoading = true;
//
//   dynamic price;
//
//   Future<void> loadProductRating() async {
//     final data = await ProductRatingService.fetchProductRating(widget.url);
//     if (data != null) {
//       setState(() {
//         ratingData = data;
//         totalRatings = (data.rating1 ?? 0) +
//             (data.rating2 ?? 0) +
//             (data.rating3 ?? 0) +
//             (data.rating4 ?? 0) +
//             (data.rating5 ?? 0);
//       });
//     }
//   }
//
//   Future<void> loadProductReview() async {
//     final response = await ProductReviewService.fetchProductReviews(widget.url);
//     if (response != null) {
//       setState(() {
//         reviews = response;
//       });
//     }
//   }
//
//   Future<void> fetchImagesList() async {
//     try {
//       final productImageList =
//           await ProductImageListService.fetchProductImagesList(
//         refNo: widget.refNo,
//         url: widget.url,
//       );
//       setState(() {
//         productImages = productImageList;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error loading images: $e");
//       setState(() => isLoading = false);
//     }
//   }
//
//   final ControllerProductDetailsList controllerProductDetailsList = Get.put(ControllerProductDetailsList());
//
//   @override
//   void initState() {
//     super.initState();
//     controllerProductDetails.getProductDetailsData(
//         url: widget.url, refNo: widget.refNo);
//     controllerProductDetailsList.getProductListData();
//     loadProductRating();
//     loadProductReview();
//     fetchImagesList();
//   }
//
//   final List<Map<String, String>> features = [
//     {"icon": "assets/images/warranty.png", "text": "6-Month Warranty"},
//     {"icon": "assets/images/exchange.png", "text": "3-Days Exchange"},
//     {"icon": "assets/images/shipping.png", "text": "Free Shipping"},
//     {"icon": "assets/images/emi.png", "text": "Easy No Cost EMIs"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Obx(() {
//           var product = controllerProductDetails.productDetails.value;
//           if (product == null) {
//             return const Text("");
//           }
//           return Text(
//             '${product.productAndModelName.toString() ?? ''} - ${product.ramName.toString() ?? ''}/ ${product.romName.toString() ?? ''}',
//             style: const TextStyle(color: Colors.black, fontSize: 14),
//           );
//         }),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//             var product = controllerProductDetails.productDetails.value;
//             if (product == null) {
//               return const SizedBox.shrink();
//             }
//             return IconButton(
//               icon: Icon(
//                 isFavorite ? Icons.favorite : Icons.favorite_border,
//                 color: Colors.redAccent,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isFavorite = !isFavorite;
//                 });
//               },
//             );
//           }),
//         ],
//       ),
//       body: Obx(() {
//         var product = controllerProductDetails.productDetails.value;
//         price = product?.sellingPrice.toString();
//         if (product == null) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.blue,
//               strokeWidth: 2,
//             ),
//           );
//         }
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: productImages.isNotEmpty
//                       ? Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black26, width: 2),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: const EdgeInsets.all(8),
//                           child: Image.network(
//                             "$imageAllBaseUrl${productImages[selectedImageIndex].image ?? ''}",
//                             height: 250,
//                             fit: BoxFit.contain,
//                           ),
//                         )
//                       : const CircularProgressIndicator(
//                           strokeWidth: 1,
//                           color: Colors.blue,
//                         ),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   height: 70,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: productImages.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedImageIndex = index;
//                           });
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: selectedImageIndex == index
//                                   ? Colors.black26
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Image.network(
//                             "${imageAllBaseUrl}${productImages[index].image ?? ''}",
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                  SizedBox(height: 15),
//                 Text(
//                   "( ${product.productAndModelName ?? ''} )  ${product.ramName ?? ''}/${product.romName ?? ''}",
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                   ),
//                 ),
//                 Text(
//                   "Display( ${product.display ?? ''} ",
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue),
//                 ),
//                 buildPricingCard(product),
//                 const SizedBox(height: 15),
//                 buildProductAttributesCard(context, product),
//                 const SizedBox(height: 20),
//                 buildProductHighlightsCard(product),
//                 const SizedBox(height: 20),
//                 _buildRecommendedProducts(product),
//                 const SizedBox(height: 20),
//                 _buildFeatureSection(),
//                 const SizedBox(height: 20),
//                 buildPincodeSection(),
//                 const SizedBox(height: 20),
//                 buildUserReviewsSection(product, reviews),
//               ],
//             ),
//           ),
//         );
//       }),
//       bottomNavigationBar: _buildBottomButtons(productImages),
//     );
//   }
//
//   Widget _buildBottomButtons(List<ProductImageListModel> productImages) {
//     final product = controllerProductDetails.productDetails.value;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Row(
//         children: [
//
//          //  Expanded(
//          //    child: (product?.stockQuantity ?? 0) == 0
//          //        ? ElevatedButton(
//          //      style: ElevatedButton.styleFrom(
//          //        backgroundColor: Colors.red,
//          //      ),
//          //      onPressed: () {
//          //        ScaffoldMessenger.of(context).showSnackBar(
//          //          const SnackBar(
//          //            content: Text("This product is currently out of stock."),
//          //            backgroundColor: Colors.redAccent,
//          //          ),
//          //        );
//          //      },
//          //      child: const Text("OUT OF STOCK",
//          //        style: TextStyle(color: Colors.white, fontSize: 14),
//          //      ),
//          //    )
//          //        : ElevatedButton(
//          //      style: ElevatedButton.styleFrom(
//          //        backgroundColor: Colors.grey,
//          //      ),
//          //      onPressed: () async {
//          //        try {
//          //          final userCode = await TokenHelper.getUserCode();
//          //          final token = await TokenHelper.getToken();
//          //
//          //          if (userCode == null || token == null) {
//          //            Get.to(() => const LoginScreen());
//          //            return;
//          //          }
//          //
//          //          final uuid = Uuid();
//          //          final cartRef = uuid.v4();
//          //          final addToCartService = AddToCartService();
//          //
//          //          final response = await addToCartService.fetchAddToCartData(
//          //            userCode,
//          //            product?.ramId?.toString(),
//          //            product?.romId?.toString(),
//          //            product?.stockQuantity?.toString(),
//          //            product?.colorId?.toString(),
//          //            product?.modelNo?.toString(),
//          //            product?.sellingPrice?.toString(),
//          //            cartRef,
//          //          );
//          //
//          //          if (response != null) {
//          //            Get.to(() => const CartScreen());
//          //          } else {
//          //            ScaffoldMessenger.of(context).showSnackBar(
//          //              const SnackBar(
//          //                content: Text("Something went wrong! Please try again."),
//          //                backgroundColor: Colors.redAccent,
//          //              ),
//          //            );
//          //          }
//          //        } catch (e) {
//          //          print("Add to Cart Error: $e");
//          //          ScaffoldMessenger.of(context).showSnackBar(
//          //            SnackBar(content: Text("An error occurred: $e"),backgroundColor: Colors.redAccent,
//          //            ),
//          //          );
//          //        }
//          //      },
//          //      child: const Text("ADD TO CART",style: TextStyle(color: Colors.black, fontSize: 14),
//          //      ),
//          //    ),
//          // ),
//           Expanded(
//             child: Builder(
//               builder: (context) {
//                 final isOutOfStock = (product?.stockQuantity ?? 0) == 0;
//
//                 if (isOutOfStock) {
//                   return ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("This product is currently out of stock."),
//                           backgroundColor: Colors.redAccent,
//                         ),
//                       );
//                     },
//                     child:  Text("OUT OF STOCK",
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   );
//                 } else {
//                   return ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey,
//                     ),
//                     onPressed: () async {
//                       try {
//                         final userCode = await TokenHelper.getUserCode();
//                         final token = await TokenHelper.getToken();
//
//                         if (userCode == null || token == null) {
//                           Get.to(() => const LoginScreen());
//                           return;
//                         }
//
//                         final uuid = Uuid();
//                         final cartRef = uuid.v4();
//                         final addToCartService = AddToCartService();
//
//                         final response = await addToCartService.fetchAddToCartData(
//                           userCode,
//                           product?.ramId?.toString(),
//                           product?.romId?.toString(),
//                           product?.stockQuantity?.toString(),
//                           product?.colorId?.toString(),
//                           product?.modelNo?.toString(),
//                           product?.sellingPrice?.toString(),
//                           cartRef,
//                         );
//
//                         if (response != null) {
//                           Get.to(() => const CartScreen());
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Something went wrong! Please try again."),
//                               backgroundColor: Colors.redAccent,
//                             ),
//                           );
//                         }
//                       } catch (e) {
//                         print("Add to Cart Error: $e");
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text("An error occurred: $e"),
//                             backgroundColor: Colors.redAccent,
//                           ),
//                         );
//                       }
//                     },
//                     child:  Text(
//                       "ADD TO CART",
//                       style: TextStyle(color: Colors.black, fontSize: 14),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//
//           if ((product?.stockQuantity ?? 0) > 0) const SizedBox(width: 10),
//            SizedBox(width: 10),
//           if ((product?.stockQuantity ?? 0) > 0)
//
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () async {
//                 final product = controllerProductDetails.productDetails.value;
//                 try {
//                   final uuid = Uuid();
//                   String cartRef = uuid.v4();
//                   print('cartRef :- $cartRef');
//
//                   final userCode = await TokenHelper.getUserCode();
//                   final token = await TokenHelper.getToken();
//                   if (userCode == null || token == null) {
//                     Get.to(() => const LoginScreen());
//                     return;
//                   }
//                   if (product == null || productImages.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Product details not available!"),
//                         backgroundColor: Colors.redAccent,
//                       ),
//                     );
//                     return;
//                   }
//                   final addToBuyNowService = AddToBuyNowService();
//                   final addToBuyNowDetails =
//                       await addToBuyNowService.fetchBuyNowData(
//                     customerId: userCode,
//                     modelId: product.modelNo.toString(),
//                     colorId: product.colorId.toString(),
//                     ramId: product.ramId.toString(),
//                     romId: product.romId.toString(),
//                     quantity: product.stockQuantity ?? 0,
//                     price: product.sellingPrice?.toDouble() ?? 0.0,
//                     cartRef: cartRef,
//                   );
//                   if (addToBuyNowDetails != null) {
//                     Get.to(
//                       () => CheckoutScreen(
//                         isSingleProduct: true,
//                         customerId: userCode,
//                         cartRef: cartRef,
//                       ),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Failed to fetch Buy Now data"),
//                         backgroundColor: Colors.redAccent,
//                       ),
//                     );
//                   }
//                 } catch (e) {
//                   print("Buy Now Error: $e");
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("An error occurred: $e"),
//                       backgroundColor: Colors.redAccent,
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//               child:
//                   const Text("BUY NOW", style: TextStyle(color: Colors.white)),
//             ),
//           )
//       ]
//       ),
//     );
//   }
//
//   Widget _buildRecommendedProducts(ProductDetailsModel product) {
//     return Obx(() {
//       var productList = controllerProductDetailsList.productDetailsList;
//       if (controllerProductDetailsList.isLoading.value) {
//         return const Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
//       }
//       if (productList.isEmpty) {
//         // return const Center(child: Text("No recommended products available."));
//         return const Center(child: Text(""));
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "You May Also Like",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//               Text(
//                 "View All",
//                 style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 230,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: productDetailsList.length,
//               itemBuilder: (context, index) {
//                 final product = productDetailsList[index];
//                 return Container(
//                   width: 200,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     elevation: 2,
//                     child: Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Center(
//                                 child: Image.network(
//                                   '${imageAllBaseUrl}${product.image ?? ''}',
//                                   height: 55,
//                                   width: 55,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Icon(Icons.image_not_supported),
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 product.productAndModelName ?? '',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Ram       ${product.ramName ?? ''}',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Rom       ${product.romName ?? ''}',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Color      ${product.colorName ?? ''}',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "₹${product.amount?.toString() ?? '0'}",
//                                     style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 16),
//                                     child: Text(
//                                       "₹${product.newModelAmt?.toString() ?? '0'}",
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                         decoration: TextDecoration.lineThrough,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 1,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 6, vertical: 2),
//                             decoration: const BoxDecoration(
//                               color: Colors.redAccent,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(8),
//                                 bottomLeft: Radius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               '${product.discountPercentage?.toString() ?? ''}%',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildFeatureSection() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         mainAxisExtent: 100,
//       ),
//       itemCount: features.length,
//       itemBuilder: (context, index) {
//         final feature = features[index];
//         return Column(
//           children: [
//             Image.asset(
//               feature["icon"]!,
//               height: 40,
//             ),
//             const SizedBox(height: 5),
//             Text(
//               feature["text"]!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
 import 'package:fonofy/Api_Service/AddToCartService/AddToBuyNowService.dart';
import 'package:fonofy/Cart_Screens/CartScreen.dart';
import 'package:fonofy/ViewScreen/LoginScreen.dart';
import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
import 'package:fonofy/model/AddToCartModel/GetBuynowModel.dart';
import 'package:fonofy/model/ProductDetailsModel/ProductReviewModel.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../Api_Service/AddToCartService/AddToCartService.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../Api_Service/ProductDetailsService/ProductImageListService.dart';
import '../Api_Service/ProductDetailsService/ProductRatingService.dart';
import '../Api_Service/ProductDetailsService/ProductReviewService.dart';
import '../Cart_Screens/CheckoutScreen.dart';
import '../TokenHelper/TokenHelper.dart';
import '../controllers/ControllerProductDetails/ControllerProductDetails.dart';
import '../controllers/ControllerProductDetails/ControllerProductList.dart';
import '../model/ProductDetailsModel/ProductDetailsListModel.dart';
import '../model/ProductDetailsModel/ProductDetailsModel.dart';
import '../model/ProductDetailsModel/ProductImageListModel.dart';
import '../model/ProductDetailsModel/ProductRatingModel.dart';
import '../utils/Colors.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildPincodeSection.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildPricingCard.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildProductAttributesCard.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildProductHighlightsCard.dart';
import '../widgets/BuyRefurbishedProductWidgets/buildUserReviewsSection.dart';
import '../Bottom_Sheet/ProductAttributeBottomSheet.dart';

// class BuyRefurbishedProductScreen extends StatefulWidget {
//   final String url;
//   final String refNo;
//
//   const BuyRefurbishedProductScreen({
//     super.key,
//     required this.url,
//     required this.refNo,
//   });
//
//   @override
//   State<BuyRefurbishedProductScreen> createState() =>
//       _ProductDetailsScreenState();
// }
//
// class _ProductDetailsScreenState extends State<BuyRefurbishedProductScreen> {
//   final ControllerProductDetails controllerProductDetails =
//       Get.put(ControllerProductDetails());
//
//   List<ProductDetailsListModel> productDetailsList = [];
//   List<AddToCartModel> productAddToCart = [];
//   List<ProductReviewModel> reviews = [];
//   List<ProductImageListModel> productImages = [];
//
//   ProductRatingModel? ratingData;
//   AddToCartModel? addToaCrtData;
//   GetBuyNowModel? getData;
//
//   int selectedImageIndex = 0;
//   int totalRatings = 0;
//
//   bool isFavorite = false;
//   bool isLoading = true;
//
//   // State for selected variant
//   String? selectedRamName;
//   String? selectedRomName;
//   String? selectedColorName;
//   double? selectedPrice;
//   String? selectedCondition;
//   String? selectedRamId;
//   String? selectedRomId;
//   String? selectedColorId;
//   dynamic selectedDiscountPercentage;
//
//   Future<void> loadProductRating() async {
//     final data = await ProductRatingService.fetchProductRating(widget.url);
//     if (data != null) {
//       setState(() {
//         ratingData = data;
//         totalRatings = (data.rating1 ?? 0) +
//             (data.rating2 ?? 0) +
//             (data.rating3 ?? 0) +
//             (data.rating4 ?? 0) +
//             (data.rating5 ?? 0);
//       });
//     }
//   }
//
//   Future<void> loadProductReview() async {
//     final response = await ProductReviewService.fetchProductReviews(widget.url);
//     if (response != null) {
//       setState(() {
//         reviews = response;
//       });
//     }
//   }
//
//   Future<void> fetchImagesList() async {
//     try {
//       final productImageList =
//           await ProductImageListService.fetchProductImagesList(
//         refNo: widget.refNo,
//         url: widget.url,
//       );
//       setState(() {
//         productImages = productImageList;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error loading images: $e");
//       setState(() => isLoading = false);
//     }
//   }
//
//   final ControllerProductDetailsList controllerProductDetailsList =
//       Get.put(ControllerProductDetailsList());
//
//   @override
//   void initState() {
//     super.initState();
//     controllerProductDetails.getProductDetailsData(
//         url: widget.url, refNo: widget.refNo);
//     controllerProductDetailsList.getProductListData();
//     loadProductRating();
//     loadProductReview();
//     fetchImagesList();
//   }
//
//   final List<Map<String, String>> features = [
//     {"icon": "assets/images/warranty.png", "text": "6-Month Warranty"},
//     {"icon": "assets/images/exchange.png", "text": "3-Days Exchange"},
//     {"icon": "assets/images/shipping.png", "text": "Free Shipping"},
//     {"icon": "assets/images/emi.png", "text": "Easy No Cost EMIs"},
//   ];
//
//   void _showAttributeBottomSheet(ProductDetailsModel product) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => ProductAttributeBottomSheet(
//         product: product,
//         onVariantSelected: (ramName, romName, colorName, price, condition,
//             ramId, romId, colorId, discountPercentage) {
//           setState(() {
//             selectedRamName = ramName;
//             selectedRomName = romName;
//             selectedColorName = colorName;
//             selectedPrice = price;
//             selectedCondition = condition;
//             selectedRamId = ramId.toString();
//             selectedRomId = romId.toString();
//             selectedColorId = colorId.toString();
//             selectedDiscountPercentage = discountPercentage;
//             controllerProductDetails.updateProductVariant(
//               ramName: ramName,
//               romName: romName,
//               colorName: colorName,
//               sellingPrice: price,
//               ramId: ramId.toString(), // Ensure String
//               romId: romId.toString(), // Ensure String
//               colorId: colorId.toString(), // Ensure String
//               discountPercentage: discountPercentage,
//             );
//           });
//           print(
//               "Parent updated: Price=$price, Condition=$condition, RamId=$ramId, RomId=$romId, ColorId=$colorId");
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Obx(() {
//           var product = controllerProductDetails.productDetails.value;
//           if (product == null) {
//             return const Text("");
//           }
//           return Text(
//             '${product.productAndModelName ?? ''} - ${selectedRamName ?? product.ramName ?? ''}/${selectedRomName ?? product.romName ?? ''}',
//             style: const TextStyle(color: Colors.black, fontSize: 14),
//           );
//         }),
//         centerTitle: true,
//         actions: [
//           Obx(() {
//             var product = controllerProductDetails.productDetails.value;
//             if (product == null) {
//               return const SizedBox.shrink();
//             }
//             return IconButton(
//               icon: Icon(
//                 isFavorite ? Icons.favorite : Icons.favorite_border,
//                 color: Colors.redAccent,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isFavorite = !isFavorite;
//                 });
//               },
//             );
//           }),
//         ],
//       ),
//       body: Obx(() {
//         var product = controllerProductDetails.productDetails.value;
//         if (product == null) {
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.blue,
//               strokeWidth: 2,
//             ),
//           );
//         }
//         // Initialize selected values if not set
//         selectedPrice ??= product.sellingPrice;
//         selectedCondition ??= "Fair";
//         selectedRamName ??= product.ramName;
//         selectedRomName ??= product.romName;
//         selectedColorName ??= product.colorName;
//         selectedRamId ??= product.ramId?.toString(); // Convert to String
//         selectedRomId ??= product.romId?.toString(); // Convert to String
//         selectedColorId ??= product.colorId?.toString(); // Convert to String
//         selectedDiscountPercentage ??= product.discountPercentage;
//
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: productImages.isNotEmpty
//                       ? Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black26, width: 2),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: const EdgeInsets.all(8),
//                           child: Image.network(
//                             "$imageAllBaseUrl${productImages[selectedImageIndex].image ?? ''}",
//                             height: 250,
//                             fit: BoxFit.contain,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 const Icon(Icons.image_not_supported),
//                           ),
//                         )
//                       : const CircularProgressIndicator(
//                           strokeWidth: 1,
//                           color: Colors.blue,
//                         ),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   height: 70,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: productImages.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedImageIndex = index;
//                           });
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: selectedImageIndex == index
//                                   ? Colors.black26
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Image.network(
//                             "$imageAllBaseUrl${productImages[index].image ?? ''}",
//                             height: 50,
//                             width: 50,
//                             fit: BoxFit.contain,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 const Icon(Icons.image_not_supported),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 GestureDetector(
//                   onTap: () => _showAttributeBottomSheet(product),
//                   child: Text(
//                     "( ${product.productAndModelName ?? ''} ) / (${selectedRamName ?? product.ramName ?? ''}/${selectedRomName ?? product.romName ?? ''} )",
//                     style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue),
//                   ),
//                 ),
//                 Text(
//                   "Display: ${product.display ?? ''}",
//                   style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue),
//                 ),
//                  SizedBox(height: 5,),
//                 buildPricingCard(product, selectedPrice: selectedPrice),
//                 const SizedBox(height: 15),
//                 buildProductAttributesCard(
//                   context,
//                   product,
//                   selectedCondition: selectedCondition,
//                   selectedRamName: selectedRamName,
//                   selectedRomName: selectedRomName,
//                 ),
//                 const SizedBox(height: 20),
//                 buildProductHighlightsCard(product),
//                 const SizedBox(height: 20),
//                 _buildRecommendedProducts(product),
//                 const SizedBox(height: 20),
//                 _buildFeatureSection(),
//                 const SizedBox(height: 20),
//                 buildPincodeSection(),
//                 const SizedBox(height: 20),
//                 buildUserReviewsSection(product, reviews),
//               ],
//             ),
//           ),
//         );
//       }),
//       bottomNavigationBar: _buildBottomButtons(productImages),
//     );
//   }
//
//   Widget _buildBottomButtons(List<ProductImageListModel> productImages) {
//     final product = controllerProductDetails.productDetails.value;
//
//     double? getPriceBasedOnCondition() {
//       print(
//           "Selected Condition: $selectedCondition, Price: $selectedPrice, RamId: $selectedRamId, RomId: $selectedRomId, ColorId: $selectedColorId");
//       if (selectedCondition == "Fair") {
//         return product?.sellingPrice ?? 0;
//       } else if (selectedCondition == "Good") {
//         return product?.sellingPriceF1 ?? product?.sellingPriceF1 ?? 0;
//       } else if (selectedCondition == "Superb") {
//         return product?.sellingPricePlus ?? product?.sellingPricePlus ?? 0;
//       }
//       return selectedPrice ?? product?.sellingPrice ?? 0;
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Builder(
//               builder: (context) {
//                 final isOutOfStock = (product?.stockQuantity ?? 0) == 0;
//
//                 if (isOutOfStock) {
//                   return ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content:
//                               Text("This product is currently out of stock."),
//                           backgroundColor: Colors.redAccent,
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "OUT OF STOCK",
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   );
//                 } else {
//                   return ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.grey),
//                     onPressed: () async {
//                       try {
//                         final userCode = await TokenHelper.getUserCode();
//                         final token = await TokenHelper.getToken();
//
//                         if (userCode == null || token == null) {
//                           Get.to(() => const LoginScreen());
//                           return;
//                         }
//
//                         final uuid = Uuid();
//                         final cartRef = uuid.v4();
//                         final addToCartService = AddToCartService();
//
//                         print(
//                             "Add to Cart - ramId: ${selectedRamId ?? product?.ramId}, romId: ${selectedRomId ?? product?.romId}, colorId: ${selectedColorId ?? product?.colorId}, price: ${getPriceBasedOnCondition()}");
//
//                         final response =
//                             await addToCartService.fetchAddToCartData(
//                           userCode,
//                           selectedRamId ?? product?.ramId?.toString() ?? '',
//                           selectedRomId ?? product?.romId?.toString() ?? '',
//                           product?.stockQuantity?.toString() ?? '0',
//                           selectedColorId ?? product?.colorId?.toString() ?? '',
//                           product?.modelNo?.toString() ?? '',
//                           getPriceBasedOnCondition()?.toString() ?? '0',
//                           cartRef,
//                         );
//
//                         if (response != null) {
//                           Get.to(() => const CartScreen());
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                   "Something went wrong! Please try again."),
//                               backgroundColor: Colors.redAccent,
//                             ),
//                           );
//                         }
//                       } catch (e) {
//                         print("Add to Cart Error: $e");
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text("An error occurred: $e"),
//                             backgroundColor: Colors.redAccent,
//                           ),
//                         );
//                       }
//                     },
//                     child: Text(
//                       "ADD TO CART",
//                       style: TextStyle(color: Colors.black, fontSize: 14),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//           if ((product?.stockQuantity ?? 0) > 0) const SizedBox(width: 10),
//           if ((product?.stockQuantity ?? 0) > 0)
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   final product = controllerProductDetails.productDetails.value;
//                   try {
//                     final uuid = Uuid();
//                     String cartRef = uuid.v4();
//                     print('cartRef :- $cartRef');
//
//                     final userCode = await TokenHelper.getUserCode();
//                     final token = await TokenHelper.getToken();
//                     if (userCode == null || token == null) {
//                       Get.to(() => const LoginScreen());
//                       return;
//                     }
//                     if (product == null || productImages.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("Product details not available!"),
//                           backgroundColor: Colors.redAccent,
//                         ),
//                       );
//                       return;
//                     }
//                     final addToBuyNowService = AddToBuyNowService();
//
//                     print(
//                         "Buy Now - ramId: ${selectedRamId ?? product?.ramId}, romId: ${selectedRomId ?? product?.romId}, colorId: ${selectedColorId ?? product?.colorId}, price: ${getPriceBasedOnCondition()}");
//
//                     final addToBuyNowDetails =
//                         await addToBuyNowService.fetchBuyNowData(
//                       customerId: userCode,
//                       modelId: product.modelNo?.toString() ?? '',
//                       colorId: selectedColorId ??
//                           product.colorId?.toString() ??
//                           '', // Convert to String
//                       ramId: selectedRamId ??
//                           product.ramId?.toString() ??
//                           '', // Convert to String
//                       romId: selectedRomId ??
//                           product.romId?.toString() ??
//                           '', // Convert to String
//                       quantity: product.stockQuantity ?? 0,
//                       price: getPriceBasedOnCondition() ?? 0.0,
//                       cartRef: cartRef,
//                     );
//                     if (addToBuyNowDetails != null) {
//                       Get.to(
//                         () => CheckoutScreen(
//                           isSingleProduct: true,
//                           customerId: userCode,
//                           cartRef: cartRef,
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text("Failed to fetch Buy Now data"),
//                           backgroundColor: Colors.redAccent,
//                         ),
//                       );
//                     }
//                   } catch (e) {
//                     print("Buy Now Error: $e");
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text("An error occurred: $e"),
//                         backgroundColor: Colors.redAccent,
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                 child: const Text(
//                   "BUY NOW",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRecommendedProducts(ProductDetailsModel product) {
//     return Obx(() {
//       var productList = controllerProductDetailsList.productDetailsList;
//       if (controllerProductDetailsList.isLoading.value) {
//         return const Center(
//             child:
//                 CircularProgressIndicator(strokeWidth: 2, color: Colors.blue));
//       }
//       if (productList.isEmpty) {
//         return const Center(child: Text(""));
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "You May Also Like",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//               Text(
//                 "View All",
//                 style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 230,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: productList.length,
//               itemBuilder: (context, index) {
//                 final recommendedProduct = productList[index];
//                 return Container(
//                   width: 200,
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     elevation: 2,
//                     child: Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Center(
//                                 child: Image.network(
//                                   '${imageAllBaseUrl}${recommendedProduct.image ?? ''}',
//                                   height: 55,
//                                   width: 55,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) =>
//                                       const Icon(Icons.image_not_supported),
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 recommendedProduct.productAndModelName ?? '',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Ram: ${recommendedProduct.ramName ?? ''}',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Rom: ${recommendedProduct.romName ?? ''}',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               Text(
//                                 'Color: ${recommendedProduct.colorName ?? ''}',
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w600),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "₹${recommendedProduct.amount?.toString() ?? '0'}",
//                                     style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 16),
//                                     child: Text(
//                                       "₹${recommendedProduct.newModelAmt?.toString() ?? '0'}",
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                         decoration: TextDecoration.lineThrough,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           top: 1,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 6, vertical: 2),
//                             decoration: const BoxDecoration(
//                               color: Colors.redAccent,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(8),
//                                 bottomLeft: Radius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               '${recommendedProduct.discountPercentage?.toString() ?? ''}%',
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 9,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildFeatureSection() {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         mainAxisExtent: 100,
//       ),
//       itemCount: features.length,
//       itemBuilder: (context, index) {
//         final feature = features[index];
//         return Column(
//           children: [
//             Image.asset(
//               feature["icon"]!,
//               height: 40,
//             ),
//             const SizedBox(height: 5),
//             Text(
//               feature["text"]!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 12),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

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

  ProductRatingModel? ratingData;


  int selectedImageIndex = 0;
  int totalRatings = 0;

  bool isFavorite = false;
  bool isLoading = true;

  String? selectedRamName;
  String? selectedRomName;
  String? selectedColorName;
  double? selectedPrice;
  String? selectedCondition;
  String? selectedRamId;
  String? selectedRomId;
  String? selectedColorId;
  dynamic selectedDiscountPercentage;

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

  final List<Map<String, String>> features = [
    {"icon": "assets/images/warranty.png", "text": "6-Month Warranty"},
    {"icon": "assets/images/exchange.png", "text": "3-Days Exchange"},
    {"icon": "assets/images/shipping.png", "text": "Free Shipping"},
    {"icon": "assets/images/emi.png", "text": "Easy No Cost EMIs"},
  ];

  void _showAttributeBottomSheet(ProductDetailsModel product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ProductAttributeBottomSheet(
        product: product,
        onVariantSelected: (ramName, romName, colorName, price, condition,
            ramId, romId, colorId, discountPercentage) {
          setState(() {
            selectedRamName = ramName;
            selectedRomName = romName;
            selectedColorName = colorName;
            selectedPrice = price;
            selectedCondition = condition;
            selectedRamId = ramId;
            selectedRomId = romId;
            selectedColorId = colorId;
            selectedDiscountPercentage = discountPercentage;
            controllerProductDetails.updateProductVariant(
              ramName: ramName,
              romName: romName,
              colorName: colorName,
              sellingPrice: price,
              ramId: ramId,
              romId: romId,
              colorId: colorId,
              discountPercentage: discountPercentage,
            );
          });
          print("Parent updated: Price=$price, Condition=$condition, RamId=$ramId, RomId=$romId, ColorId=$colorId");
        },
      ),
    );
  }

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
            '${product.productAndModelName ?? ''} - ${selectedRamName ?? product.ramName ?? ''}/${selectedRomName ?? product.romName ?? ''}',
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
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            );
          }),
        ],
      ),
      backgroundColor: Colors.white ,
      body: Obx(() {

        var product = controllerProductDetails.productDetails.value;
        if (product == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ),
          );
        }
         selectedPrice ??= product.sellingPrice;
        selectedCondition ??= "Fair";
        selectedRamName ??= product.ramName;
        selectedRomName ??= product.romName;
        selectedColorName ??= product.colorName;
        selectedRamId ??= product.ramId?.toString();
        selectedRomId ??= product.romId?.toString();
        selectedColorId ??= product.colorId?.toString();
        selectedDiscountPercentage ??= product.discountPercentage;
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
                      border: Border.all(color: Colors.white, width: 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.network("$imageAllBaseUrl${productImages[selectedImageIndex].image ?? ''}",
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image,color: ColorConstants.appBlueColor3,),
                    ),
                  )
                      :   CircularProgressIndicator(strokeWidth: 1,color: Colors.blue,
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
                          margin:   EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedImageIndex == index
                                  ? ColorConstants.appBlueColor3
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.network(
                            "$imageAllBaseUrl${productImages[index].image ?? ''}",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image,color: ColorConstants.appBlueColor3,),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => _showAttributeBottomSheet(product),
                  child: Text(
                    "( ${product.productAndModelName ?? ''} ) / (${selectedRamName ?? product.ramName ?? ''}/${selectedRomName ?? product.romName ?? ''} )",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.appBlueColor3),
                  ),
                ),
                Text("Display:  ${product.display ?? ''}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.appBlueColor3),
                ),
                const SizedBox(height: 10),
                buildPricingCard(product, selectedPrice: selectedPrice),
                const SizedBox(height: 15),
                buildProductAttributesCard(context, product, selectedCondition: selectedCondition,selectedRamName: selectedRamName, selectedRomName: selectedRomName,),
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

    final product = controllerProductDetails.productDetails.value;

    double? getPriceBasedOnCondition() {
      if (selectedCondition == "Fair") {
        return product?.sellingPrice ?? 0;
      } else if (selectedCondition == "Good") {
        return product?.sellingPriceF1 ?? 0;
      } else if (selectedCondition == "Superb") {
        return product?.sellingPricePlus ?? 0;
      }
      return selectedPrice ?? product?.sellingPrice ?? 0;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                final isOutOfStock = (product?.stockQuantity ?? 0) == 0;
                if (isOutOfStock) {
                  return ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content:
                          Text("This product is currently out of stock."),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    },
                    child: Text("OUT OF STOCK",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () async {
                      try {
                        final userCode = await TokenHelper.getUserCode();
                        final token = await TokenHelper.getToken();

                        if (userCode == null || token == null) {
                          Get.to(() => const LoginScreen());
                          return;
                        }

                        final uuid = Uuid();
                        final cartRef = uuid.v4();
                        final addToCartService = AddToCartService();

                        final price = getPriceBasedOnCondition();

                        print("Buy Now - ramId: $selectedRamId, romId: $selectedRomId, colorId: $selectedColorId, price: $price");
                        final response = await addToCartService.fetchAddToCartData(
                          userCode,
                          selectedRamId ?? product?.ramId?.toString() ?? '',
                          selectedRomId ?? product?.romId?.toString() ?? '',
                          product?.stockQuantity?.toString() ?? '0',
                          selectedColorId ?? product?.colorId?.toString() ?? '',
                          product?.modelNo?.toString() ?? '',
                          price,
                          cartRef,
                        );

                        if (response != null) {
                          Get.to(() => const CartScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Something went wrong! Please try again."),
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
                    child: Text("ADD TO CART",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  );
                }
              },
            ),
          ),

          if ((product?.stockQuantity ?? 0) > 0) const SizedBox(width: 10),
          if ((product?.stockQuantity ?? 0) > 0)

            // boy Now Screen

            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final product = controllerProductDetails.productDetails.value;
                  try {
                    final uuid = Uuid();
                    String cartRef = uuid.v4();
                    print('cartRef :- $cartRef');

                    final userCode = await TokenHelper.getUserCode();
                    final token = await TokenHelper.getToken();
                    if (userCode == null || token == null) {
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
                    final addToBuyNowService = AddToBuyNowService();
                    final price = getPriceBasedOnCondition();

                     print("Buy Now - ramId: $selectedRamId, romId: $selectedRomId, colorId: $selectedColorId, price: $price");

                    final addToBuyNowDetails = await addToBuyNowService.fetchBuyNowData(
                      customerId: userCode,
                      modelId: product.modelNo?.toString() ?? '',
                      colorId: selectedColorId ?? product.colorId?.toString() ?? '',
                      ramId: selectedRamId ?? product.ramId?.toString() ?? '',
                      romId: selectedRomId ?? product.romId?.toString() ?? '',
                      quantity: product.stockQuantity ?? 0,
                      price: product.sellingPrice,
                      cartRef: cartRef,

                    );
                    if (addToBuyNowDetails != null) {
                      Get.to(() => CheckoutScreen(isSingleProduct: true,
                          customerId: userCode,
                          cartRef: cartRef,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to fetch Buy Now data"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
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
                style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.appBlueColor3),
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
        return const Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue));
      }
      if (productList.isEmpty) {
        return const Center(child: Text(""));
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
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final recommendedProduct = productList[index];
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
                          padding:   EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  '${imageAllBaseUrl}${recommendedProduct.image ?? ''}',
                                  height: 55,
                                  width: 55,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                   Icon(Icons.image,color: ColorConstants.appBlueColor3,),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(recommendedProduct.productAndModelName ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Ram: ${recommendedProduct.ramName ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Rom: ${recommendedProduct.romName ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Color: ${recommendedProduct.colorName ?? ''}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "₹${recommendedProduct.amount?.toString() ?? '0'}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      "₹${recommendedProduct.newModelAmt?.toString() ?? '0'}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                              '${recommendedProduct.discountPercentage?.toString() ?? ''}%',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold),
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