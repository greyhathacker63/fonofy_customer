import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/ProductDetailsModel/SearchCompareProductModel.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../controllers/SearchController/SearchCompareController.dart';
import '../utils/Colors.dart';

class CompareScreen extends StatefulWidget {
  final List<SearchCompareProductModel> selectedProducts;

  const CompareScreen({Key? key, required this.selectedProducts})
      : super(key: key);

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late List<SearchCompareProductModel?> selectedProducts;
  bool showSearch = false;

  final TextEditingController searchProductController = TextEditingController();
  final SearchCompareController searchCompareController = Get.put(SearchCompareController());
  Timer? _debounce;

  final List<Map<String, String>> featureList = [
    {'label': 'Price', 'key': 'price'},
    {'label': 'Available', 'key': 'available'},
    {'label': 'Stock Status', 'key': 'stock'},
    {'label': 'RAM', 'key': 'ram'},
    {'label': 'ROM', 'key': 'rom'},
    {'label': 'Display', 'key': 'display'},
    {'label': 'Battery', 'key': 'battery'},
    {'label': 'Front Camera', 'key': 'frontCamera'},
    {'label': 'Rear Camera', 'key': 'rearCamera'},
    {'label': 'Processor', 'key': 'processor'},
    {'label': 'Product Rating', 'key': 'rating'},
  ];

  @override
  void initState() {
    super.initState();
    selectedProducts =
        List<SearchCompareProductModel?>.from(widget.selectedProducts);
    while (selectedProducts.length < 3) {
      selectedProducts.add(null);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchProductController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      if (query.trim().isEmpty) {
        searchCompareController.productSearchList.clear();
        return;
      }
      searchCompareController.searchProducts(query);
      print('Search Query: $query');
      print('Search Results: ${searchCompareController.productSearchList.map((e) => {'Name': e.name, 'Amount': e.amount}).toList()}');
    });
  }

  void _removeProduct(int index) {
    final count = selectedProducts.where((e) => e != null).length;
    if (count > 0) { // Require at least 2 products for comparison
      setState(() => selectedProducts[index] = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least two products must remain for comparison.')),
      );
    }
  }

  void _addProduct(int index) {
    if (selectedProducts[index] == null) {
      setState(() => showSearch = true);
    }
  }

  String getFeatureValue(String key, SearchCompareProductModel product) {
    switch (key) {
      case 'price':
        return "₹${product.amount?.toString() ?? 'N/A'}";
      case 'available':
        return product.url != null && product.url!.isNotEmpty ? "Yes" : "No";
      case 'stock':
        return product.amount != null && product.amount! > 0 ? "In Stock" : "Out of Stock";
      case 'ram':
        return 'N/A';
      case 'rom':
        return 'N/A';
      case 'display':
        return 'N/A';
      case 'battery':
        return 'N/A';
      case 'frontCamera':
        return 'N/A';
      case 'rearCamera':
        return 'N/A';
      case 'processor':
        return 'N/A';
      case 'rating':
        return 'N/A';
      default:
        return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Compare Products"),backgroundColor: Colors.white,),
      body: Column(
        children: [
          if (showSearch)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchProductController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Search product...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showSearch = true; // Fixed: Hide search bar
                          searchProductController.clear();
                          searchCompareController.productSearchList.clear();
                        });
                      },
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          Obx(() {
            if (searchCompareController.isLoading.value) {
              return LinearProgressIndicator(color: ColorConstants.appBlueColor3);
            }
            if (showSearch) {
              return Expanded(
                child: searchCompareController.productSearchList.isEmpty
                    ? Center(child: Text('No products found'))
                    : ListView.builder(
                  itemCount: searchCompareController.productSearchList.length,
                  itemBuilder: (context, index) {
                    final searchData = searchCompareController.productSearchList[index];
                    return InkWell(
                      onTap: () {
                        final firstNullIndex = selectedProducts.indexWhere((p) => p == null);
                        if (firstNullIndex != -1) {
                          setState(() {
                            selectedProducts[firstNullIndex] = searchData;
                            showSearch = false;
                            searchCompareController.productSearchList.clear();
                            searchProductController.clear();
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Image.network(
                              '$imageAllBaseUrl${searchData.image ?? ''}',
                              height: 55,
                              width: 55,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image, color: ColorConstants.appBlueColor3),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchData.name ?? '',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "₹ ${searchData.amount?.toString() ?? 'Price not available'}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: searchData.amount != null ? Colors.black : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Expanded(
                child: Row(
                  children: List.generate(3, (index) {
                    final product = selectedProducts[index];
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: product != null
                            ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.network(
                                      '$imageAllBaseUrl${product.image ?? ''}',
                                      height: 120,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Image.asset('assets/images/placeholder.png',
                                              height: 120),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () => _removeProduct(index),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Icon(Icons.close,
                                            size: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  product.name ?? '',
                                  style:   TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...featureList.map((feature) {
                                final value = getFeatureValue(feature['key']!, product);
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(color: Colors.grey.shade200)),
                                    color: Colors.blue.shade50,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        feature['label']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(value, style: const TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        )
                            : GestureDetector(
                          onTap: () => _addProduct(index),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            child: FittedBox(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorConstants.appBlueColor3,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add, color: Colors.white, size: 30),
                                    SizedBox(width: 6),
                                    Text(
                                      "Add Product",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}