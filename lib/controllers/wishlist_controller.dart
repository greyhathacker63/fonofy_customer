import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/model/wishlist_model.dart';
import '../Api_Service/Wishlist/wishlist_service.dart';

class WishlistController extends GetxController {
  List<WishlistModel> _wishlistItems = [];
  List<WishlistModel> get wishlistItems => _wishlistItems;

  var isLoading = true.obs;

  /// Fetch wishlist data from API
  Future<void> fetchWishlistData() async {
    try {
      isLoading.value = true;

      final response = await WishlistService.fetchWishlist();

      if (response.isNotEmpty) {
        _wishlistItems = response;
      } else {
        _wishlistItems = [];
        debugPrint('Wishlist API returned empty list');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in Wishlist Data: $e');
      debugPrint('Stacktrace: $stackTrace');
      _wishlistItems = [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Add product to wishlist using API
  void addProductToWishlist({
    required int productId,
    required String customerId,
    required int quantity,
    required int modelId,
    required int brandId,
    required int colorId,
    required int ramId,
    required int romId,
    String? cartRef, // Make cartRef nullable
  }) async {
    isLoading.value = true;

    // First, fetch the current wishlist to check if the product is already in the wishlist
    List<WishlistModel> currentWishlist = await WishlistService.fetchWishlist();

    bool isProductAlreadyInWishlist = currentWishlist.any((item) =>
        item.productId == productId); // Use the correct property name here

    if (isProductAlreadyInWishlist) {
      Get.snackbar("Info", "This product is already in your wishlist.");
      isLoading.value = false;
      return;
    }

    bool success = await WishlistService.addToWishlist(
      productId: productId,
      customerId: customerId,
      quantity: quantity,
      modelId: modelId,
      brandId: brandId,
      colorId: colorId,
      ramId: ramId,
      romId: romId,
      cartRef: cartRef,
    );

    isLoading.value = false;

    if (success) {
      Get.snackbar("Success", "Product added to wishlist");
      await fetchWishlistData(); // Refresh after successful add
    } else {
      Get.snackbar("Error", "Failed to add product to wishlist");
    }
  }

  /// Remove product from wishlist using API
  void removeProductFromWishlist({required int productId}) async {
    isLoading.value = true;

    bool success = await WishlistService.removeFromWishlist(productId.toString());

    isLoading.value = false;

    if (success) {
      Get.snackbar("Success", "Product removed from wishlist");
      await fetchWishlistData(); // Refresh after successful removal
    } else {
      Get.snackbar("Error", "Failed to remove product from wishlist");
    }
  }
}
