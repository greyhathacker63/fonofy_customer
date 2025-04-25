import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/Wishlist/wishlist_service.dart';
import '../TokenHelper/TokenHelper.dart';

class WishlistController extends ChangeNotifier {
  Set<String> wishlistProductIds = {};

  Future<void> addProduct(String productId) async {
    final userCode = await TokenHelper.getUserCode();
    if (userCode == null) return;

    final isAdded = await WishlistService.addToWishlist(
      customerId: userCode,
      productId: productId,
    );

    if (isAdded) {
      wishlistProductIds.add(productId);
      notifyListeners();
    }
  }

  Future<void> removeProduct(String productId) async {
    final userCode = await TokenHelper.getUserCode();
    if (userCode == null) return;

    final isRemoved = await WishlistService.removeFromWishlist(
      customerId: userCode,
      productId: productId,
    );

    if (isRemoved) {
      wishlistProductIds.remove(productId);
      notifyListeners();
    }
  }

  bool isInWishlist(String productId) {
    return wishlistProductIds.contains(productId);
  }
}
