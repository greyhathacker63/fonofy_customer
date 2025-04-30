import 'package:flutter/material.dart';
import 'package:fonofy/controllers/wishlist_controller.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    super.initState();
    wishlistController.fetchWishlistData();
  }

  Future<void> _onRefresh() async {
    await wishlistController.fetchWishlistData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Obx(() {
        if (wishlistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (wishlistController.wishlistItems.isEmpty) {
          return const Center(child: Text("No items in wishlist"));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: GridView.builder(
              itemCount: wishlistController.wishlistItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.58,
              ),
              itemBuilder: (context, index) {
                var wishlistItem = wishlistController.wishlistItems[index];

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            wishlistItem.image ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Icon(Icons.broken_image, size: 50)),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Info
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        wishlistItem.productAndModelName ?? 'N/A',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        wishlistItem.modelNo?.toString() ?? 'Model No.',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Move to Cart Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 36,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // TODO: Implement Move to Cart logic
                                        Get.snackbar("Action", "Moved to Cart feature coming soon!",
                                            snackPosition: SnackPosition.BOTTOM);
                                      },
                                      child: const Text('Move to Cart', style: TextStyle(fontSize: 13)),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: ColorConstants.appBlueColor3,
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(color: Colors.teal),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      // Delete Icon
                      GestureDetector(
                        onLongPress: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Remove Item"),
                              content: const Text("Are you sure you want to remove this item from wishlist?"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
                                TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Remove")),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            wishlistController.removeProductFromWishlist(
                              productId: wishlistItem.productId,
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.delete, color: Colors.red, size: 18),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
