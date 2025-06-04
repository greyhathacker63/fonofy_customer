import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fonofy/models/WishlistModel/WishlistModel.dart';
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
        debug// print('Wishlist API returned empty list');
      }
    } catch (e, stackTrace) {
      debug// print('Error in Wishlist Data: $e');
      debug// print('Stacktrace: $stackTrace');
      _wishlistItems = [];
    } finally {
      isLoading.value = false;
    }
  }

  void addProductToWishlist({
  required String productId,
  int? quantity,
  int? modelId,
  int? brandId,
  required String colorId,
  required String ramId,
  required String romId,
  String? cartRef,
}) async {
  isLoading.value = true;

  List<WishlistModel> currentWishlist = [];

  try {
    currentWishlist = await WishlistService.fetchWishlist();
  } catch (e) {
    // Handle cases like 404 or failed network calls by treating it as empty
    debug// print("fetchWishlist failed (assume empty): $e");
  }

  // Check if same variant is already in wishlist
  bool isProductAlreadyInWishlist = currentWishlist.any((item) =>
      item.modelNo.toString() == productId &&
      item.colorId.toString() == colorId &&
      item.romId.toString() == romId &&
      item.ramId.toString() == ramId);

  if (isProductAlreadyInWishlist) {
    //Get.snackbar("Info", "This product is already in your wishlist.");
    isLoading.value = false;
    return;
  }

  // Attempt to add
  bool success = await WishlistService.addToWishlist(
    productId: productId,
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
    await fetchWishlistData();
  } else {
    //Get.snackbar("Error", "Failed to add product to wishlist");
  }
  // else {
  //   Get.snackbar("Error", "Failed to add product to wishlist");
  // }
}

  /// Remove product from wishlist using API
  void removeFromWishlist({
    required String wishlistId,
    int? quantity,
    required String modelId,
    int? brandId,
    required String colorId,
    required String ramId,
    required String romId,
    String? cartRef, 
  }) async {
    isLoading.value = true;

    bool success = await WishlistService.removeFromWishlist(
     wishlistId:wishlistId,
      modelId: modelId,
      colorId: colorId,
      ramId: ramId,
      romId: romId,
    );

    isLoading.value = false;

    // if (success) {
    //   Get.snackbar("Success", "Product removed from wishlist");
    //   await fetchWishlistData(); // Refresh after successful remove
    // } else {
    //   Get.snackbar("Error", "Failed to remove product from wishlist");
    // }
  }
}
