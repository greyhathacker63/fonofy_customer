import 'package:flutter/material.dart';
import 'package:fonofy/controllers/product_controller.dart';
import 'package:fonofy/controllers/wishlist_controller.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';
import 'package:get/get.dart';

import '../../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  final WishlistController wishlistController = Get.put(WishlistController());
  final ProductController productController = Get.put(ProductController());

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
    return Scaffold(backgroundColor: Colors.white,
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
      body: SafeArea(
        child: Obx(() {
          if (wishlistController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (wishlistController.wishlistItems.isEmpty) {
            return const Center(child: Text("No items in wishlist"));
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
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
                      // Image + Delete icon overlay
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: (wishlistItem.image ?? '')
                                      .startsWith('assets/')
                                  ? Image.asset(wishlistItem.image!,
                                      fit: BoxFit.cover)
                                  : Image.network(
                                      '$imageAllBaseUrl${wishlistItem.image ?? ""}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          const Center(
                                              child: Icon(Icons.broken_image,
                                                  size: 50)),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2));
                                      },
                                    ),
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: GestureDetector(
                              onTap: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Remove Item"),
                                    content: const Text(
                                        "Are you sure you want to remove this item from wishlist?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, false),
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, true),
                                          child: const Text("Remove")),
                                    ],
                                  ),
                                );
                                if (confirm == true) {
                                  wishlistController.removeFromWishlist(
                                    wishlistId: wishlistItem.id.toString(),
                                    modelId: wishlistItem.modelNo.toString(),
                                    colorId: wishlistItem.colorId.toString(),
                                    ramId: wishlistItem.ramId.toString(),
                                    romId: wishlistItem.romId.toString(),
                                  );

                                  // Remove item from the list immediately
                                  wishlistController.wishlistItems
                                      .removeAt(index);
                                }
                            
                              },
                              child: const Icon(Icons.close,
                                  size: 18, color: Colors.black26),
                            ),
                          )
                        ],
                      ),

                      // Info + button
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wishlistItem.productAndModelName ?? 'N/A',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${wishlistItem.ramName ?? 'Ram'} | ${wishlistItem.romName ?? 'Rom'}',
                                style: const TextStyle(fontSize: 10),
                                maxLines: 1,
                              ),
                              Text(
                                '₹${wishlistItem.price ?? ''}',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.green),
                              ),
                              const Spacer(),
                              // SizedBox(
                              //   width: double.infinity,
                              //   height: 36,
                              //   child: OutlinedButton(
                              //     onPressed: () {
                              //       Get.snackbar("Action",
                              //           "Moved to Cart feature coming soon!",
                              //           snackPosition: SnackPosition.BOTTOM);
                              //     },
                              //     style: OutlinedButton.styleFrom(
                              //       backgroundColor:
                              //           ColorConstants.appBlueColor3,
                              //       foregroundColor: Colors.white,
                              //       side: const BorderSide(color: Colors.teal),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(8)),
                              //     ),
                              //     child: const Text('Move to Cart',
                              //         style: TextStyle(fontSize: 13)),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
