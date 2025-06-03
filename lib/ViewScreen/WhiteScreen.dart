import 'package:fonofy/BuyScreen/BuyScreen.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';
import 'package:fonofy/controllers/search_product_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WhiteScreen extends StatefulWidget {
  const WhiteScreen({super.key});

  @override
  State<WhiteScreen> createState() => _WhiteScreenState();
}

class _WhiteScreenState extends State<WhiteScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchProductController searchController =
      Get.put(SearchProductController());

  @override
  void dispose() {
    _searchController.dispose();
    searchController.productList.clear(); // 🧼 clear search results
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    if (query.trim().isNotEmpty) {
      await searchController.fetchSearchProducts(query);
    } else {
      searchController.productList.clear(); // clear results if query is empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (value) {
            _handleSearch(value);
            setState(() {}); // update suffixIcon visibility
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      _searchController.clear();
                      searchController.productList.clear();
                      Navigator.pop(context); // go back after clearing
                    },
                  )
                : null,
          ),
        ),
      ),
      body: Obx(() {
        if (searchController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (searchController.productList.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return ListView.builder(
          itemCount: searchController.productList.length,
          itemBuilder: (context, index) {
            final product = searchController.productList[index];
            return ListTile(
                leading: const Icon(Icons.phone_android),
                title: Text(product.name),
                subtitle: Text(product.url),
                onTap: () {
                  Get.to(() => BuyRefurbishedProductScreen(
                        url: product.url,
                        refNo: product.refNo,
                      ));
                });
          },
        );
      }),
    );
  }
}
