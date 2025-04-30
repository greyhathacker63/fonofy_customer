import 'package:flutter/material.dart';
import 'package:fonofy/model/wishlist_model.dart';
import 'package:get/get.dart';

import '../Api_Service/Wishlist/wishlist_service.dart';

class WishlistController extends GetxController {
  // List<WishlistModel> _wishlistItems = [];
  // List<WishlistModel> get wishlistItems => _wishlistItems;
  // bool isLoading = false;
  // /// Load wishlist from API
  // Future<void> fetchWishlist() async {
  //   isLoading = true;
  //   notifyListeners();
  //   final userCode = await TokenHelper.getUserCode();
  //   if (userCode == null) {
  //     isLoading = false;
  //     notifyListeners();
  //     return;
  //   }
  //   _wishlistItems = await WishlistService.fetchWishlist(userCode);
  //   isLoading = false;
  //   notifyListeners();
  // }
  // /// Check if product is in wishlist
  // bool isInWishlist(String ucode) {
  //   return _wishlistItems.any((item) => item.ucode == ucode);
  // }
  // /// Add to wishlist (optional: if you want local update)
  // void addToWishlist(WishlistModel item) {
  //   _wishlistItems.add(item);
  //   notifyListeners();
  // }
  // /// Remove from wishlist (local)
  // void removeFromWishlist(String ucode) {
  //   _wishlistItems.removeWhere((item) => item.ucode == ucode);
  //   notifyListeners();
  // }
  // /// Clear wishlist (optional)
  // void clearWishlist() {
  //   _wishlistItems.clear();
  //   notifyListeners();
  // }

  List<WishlistModel> _wishlistItems = [];

  List<WishlistModel> get wishlistItems => _wishlistItems;

  var isLoading = true.obs;

  Future<void> fetchWishlistData() async {
    try {
      isLoading.value = false;
// not isLoading(false)

      final response = await WishlistService.fetchWishlist();

      if (response.isNotEmpty) {
        _wishlistItems = response;
      } else {
        _wishlistItems = []; // Empty list if API returned no items
        debugPrint('Wishlist API returned empty list');
      }
    } catch (e, stackTrace) {
      debugPrint('Error in Wishlist Data!!!!! : $e');
      debugPrint('Stacktrace: $stackTrace');
      _wishlistItems = []; // On error, clear list to avoid old data
    } finally {
      isLoading(false); // Loading end
    }
  }
}
