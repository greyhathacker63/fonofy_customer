import 'package:flutter/material.dart';
import 'package:fonofy/Bottom_Sheet/ProductAtrributeBottomSheet.dart';
import 'package:fonofy/Wishlist/WishlistScreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedImageIndex = 0;

  final List<String> productImages = [
    "assets/images/main_product.png",
    "assets/images/thumb_1.png",
    "assets/images/thumb_2.png",
    "assets/images/thumb_3.png",
    "assets/images/thumb_4.png",
  ];

  final List<Map<String, String>> recommendedProducts = [
    {
      "image": "assets/images/phone.png",
      "name": "Apple iPhone 6 Plus 32GB...",
      "price": "₹17,699",
      "oldPrice": "₹43,000",
      "emi": "₹926 / Month"
    },
    {
      "image": "assets/images/phone.png",
      "name": "Apple iPhone 6 Plus 32GB...",
      "price": "₹17,699",
      "oldPrice": "₹43,000",
      "emi": "₹926 / Month"
    },
    {
      "image": "assets/images/phone.png",
      "name": "Apple iPhone 6 Plus 32GB...",
      "price": "₹17,699",
      "oldPrice": "₹43,000",
      "emi": "₹926 / Month"
    },
    {
      "image": "assets/images/phone.png",
      "name": "Apple iPhone 6 Plus 32GB...",
      "price": "₹17,699",
      "oldPrice": "₹43,000",
      "emi": "₹926 / Month"
    },
  ];

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
        title: const Text(
          "Redmi 6 Pro 3GB/32GB Grade D",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.blue),
            onPressed: () {
              Get.to(() => WishlistScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    productImages[selectedImageIndex],
                    height: 250,
                    fit: BoxFit.contain,
                  ),
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
                        child: Image.asset(
                          productImages[index],
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
              const Text(
                "(Refurbished) Redmi 6 Pro Max (Champagne Gold, 6GB RAM, 128GB Storage) - 64MP Quad...",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              _buildPricingCard(),
              const SizedBox(height: 15),
              _buildProductAttributesCard(context),
              const SizedBox(height: 20),
              _buildProductHighlightsCard(),
              const SizedBox(height: 20),
              _buildRecommendedProducts(),
              const SizedBox(height: 20),
              _buildFeatureSection(),
              const SizedBox(height: 20),
              _buildPincodeSection(),
              const SizedBox(height: 20),
              buildUserReviewsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildPricingCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Text("-53%",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text("₹11,899",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(width: 8),
                Text("₹23,320",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough)),
              ],
            ),
            SizedBox(height: 5),
            Text("prepaid ₹10,947",
                style: TextStyle(color: Colors.blue, fontSize: 14)),
            SizedBox(height: 5),
            Text("₹1,823/month EMI available.",
                style: TextStyle(fontSize: 14, color: Colors.black)),
            SizedBox(height: 5),
            Text("View Plans",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("Cardless and No Cost EMI Available on credit/debit card",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("You May Also Like",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Text("View All",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedProducts.length,
            itemBuilder: (context, index) {
              final product = recommendedProducts[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(product["image"]!,
                          height: 100, fit: BoxFit.cover),
                      const SizedBox(height: 8),
                      Text(product["name"]!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(product["price"]!,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(product["emi"]!,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
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

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("ADD TO CART"))),
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

  Widget _buildProductHighlightsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Highlights",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const Divider(),
            _buildProductHighlightRow("SKU", "PBREDME512"),
            _buildProductHighlightRow("Model", "Redmi Note 9 Pro Max"),
            _buildProductHighlightRow("Brand", "Redmi"),
            _buildProductHighlightRow("Category", "SmartPhone"),
            _buildProductHighlightRow("Network", "4G"),
            _buildProductHighlightRow("RAM", "4GB"),
            _buildProductHighlightRow("ROM", "64GB"),
            _buildProductHighlightRow(
                "Battery", "Built-In Rechargeable Lithium-Ion Battery"),
            _buildProductHighlightRow("Color", "Atlantic Green"),
            _buildProductHighlightRow("OS", "Android 12"),
            const SizedBox(height: 10),
            const Text("View All Specification",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
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
          Text(value,
              style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }
}

Widget _buildProductAttributesCard(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => const ProductAttributeBottomSheet(),
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
                Icons.phone_android, "Condition", "Good", "+2 more"),
            const Divider(),
            _buildAttributeRow(
                Icons.sd_storage, "Storage", "8GB / 128 GB", "+1 more"),
            const Divider(),
            _buildAttributeRow(Icons.circle, "Color", "Blue", "+5 more",
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
          Text(value,
              style:
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


Widget buildUserReviewsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "User Reviews",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),

      // Summary Card
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rating Box
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "4.7",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Stars and count
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star_half, color: Colors.orange, size: 18),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("1108 reviews", style: TextStyle(fontSize: 14, color: Colors.black)),

                    const SizedBox(height: 12),

                    // Ratings breakdown
                    for (var rating in [
                      {"star": 5, "count": 807},
                      {"star": 4, "count": 283},
                      {"star": 3, "count": 18},
                      {"star": 2, "count": 0},
                      {"star": 1, "count": 0},
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text("${rating["star"]}", style: const TextStyle(fontSize: 12)),
                            const Icon(Icons.star, size: 14, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: (rating["count"] as int) / 1108,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text("(${rating["count"]})", style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 20),

      // Review 1
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Text("Anshuman Mohapatra", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Icon(Icons.verified, size: 16, color: Colors.black54),
                ],
              ),
              Text("16/4/2025", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(height: 28),
        ],
      ),

      // Review 2
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Good", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Nice"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Text("Deepak", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Icon(Icons.verified, size: 16, color: Colors.black54),
                ],
              ),
              Text("16/4/2025", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(height: 28),
        ],
      ),

      // Review 3
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Good experience", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Good experience"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Text("Deepak", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Icon(Icons.verified, size: 16, color: Colors.black54),
                ],
              ),
              Text("16/4/2025", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    ],
  );
}
