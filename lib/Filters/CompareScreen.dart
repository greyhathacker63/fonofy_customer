import 'package:flutter/material.dart';
import '../Api_Service/ProductDetailsService/SearchProductService.dart';
import '../model/ProductDetailsModel/GetSearchProductsModel.dart';
import '../model/ProductDetailsModel/SearchCompareProductModel.dart';
import '../utils/Colors.dart';

class CompareScreen extends StatefulWidget {
  final List<SearchCompareProductModel> selectedProducts;

  const CompareScreen({Key? key, required this.selectedProducts}) : super(key: key);

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late List<SearchCompareProductModel?> selectedProducts;
  List<GetSearchProductsModel> _searchResults = [];
  bool isLoading = false;
  bool showSearch = false;

  final TextEditingController searchProductController = TextEditingController();

  final List<Map<String, String>> featureList = [
    {'label': 'Price', 'key': 'price'},
    {'label': 'Availaible', 'key': 'availaible'},
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
    selectedProducts = List<SearchCompareProductModel?>.from(widget.selectedProducts);
    while (selectedProducts.length < 3) {
      selectedProducts.add(null);
    }
  }

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults.clear());
      return;
    }
    setState(() => isLoading = true);
    try {
      final results = await SearchProductService.fetchProductDetailsSearch(query);
      setState(() {
        _searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching search results: $e');
    }
  }

  void _removeProduct(int index) {
    final count = selectedProducts.where((e) => e != null).length;
    if (count > 0) {
      setState(() => selectedProducts[index] = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one product must remain.')),
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
        return "₹${product.amount ?? 'N/A'}";
      case 'availaible':
        return "Yes";
      case 'stock':
        return "In-Stock";
      case 'ram':
      case 'rom':
      case 'display':
      case 'battery':
      case 'frontCamera':
      case 'rearCamera':
      case 'processor':
      case 'rating':
        return "N/A"; // These can be mapped later from API if needed
      default:
        return "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Compare Products")),
      body: Column(
        children: [
          if (showSearch)
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10,top: 22),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: Offset(0,1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                     Icon(Icons.search, color: Colors.black),
                     SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchProductController,
                        onChanged: _onSearchChanged,
                        decoration: const InputDecoration(
                          hintText: 'Search product...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showSearch = false;
                          searchProductController.clear();
                          _searchResults.clear();
                        });
                      },
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          if (isLoading) const LinearProgressIndicator(),

          if (showSearch)
            Expanded(
              child: _searchResults.isEmpty && !isLoading
                  ? const Center(child: Text('No product found'))
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return ListTile(
                    title: Text(item.name ?? ''),
                    subtitle: Text("${item.url}"),
                    onTap: () async {
                      try {
                        final compareData = await SearchProductService.fetchSearchProductsList(item.url ?? '');
                        if (compareData.isNotEmpty) {
                          final productFromCompare = compareData.first;
                          setState(() {
                            final firstNullIndex = selectedProducts.indexWhere((p) => p == null);
                            if (firstNullIndex != -1) {
                              selectedProducts[firstNullIndex] = productFromCompare;
                              showSearch = false;
                              _searchResults.clear();
                              searchProductController.clear();
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No comparison data found.')),
                          );
                        }
                      } catch (e) {
                        print("Compare API error: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },
                  );
                },
              ),
            ),

          if (!showSearch)
            Expanded(
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
                                    "https://api.fonofy.in${product.image}",
                                    height: 120,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset('assets/images/placeholder.png', height: 120),
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
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(Icons.close, size: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product.name ?? '',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...featureList.map((feature) {
                              final value = getFeatureValue(feature['key']!, product);
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Colors.grey.shade200),
                                  ),
                                  color: Colors.blue.shade50,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feature['label']!,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
                          padding: const EdgeInsets.all(12),
                          child: FittedBox(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorConstants.appBlueColor3,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.add, color: Colors.white, size: 30),
                                  SizedBox(width: 6),
                                  Text(
                                    "Add Product",
                                    style: TextStyle(
                                      fontSize: 20,
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
            ),
        ],
      ),
    );
  }
}
