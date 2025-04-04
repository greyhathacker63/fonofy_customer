import 'package:flutter/material.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart';
import 'package:fonofy/widgets/Colors.dart';

class CompareScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  const CompareScreen({Key? key, required this.selectedProducts})
      : super(key: key);

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late List<Product?> selectedProducts;

  final List<Map<String, String>> featureList = [
    {'label': 'Price', 'key': 'price'},
    {'label': 'RAM', 'key': 'ram'},
    {'label': 'ROM', 'key': 'rom'},
    {'label': 'Display', 'key': 'display'},
    {'label': 'Battery', 'key': 'battery'},
    {'label': 'Front Camera', 'key': 'frontCamera'},
    {'label': 'Rear Camera', 'key': 'rearCamera'},
    {'label': 'Processor', 'key': 'processor'},
  ];

  @override
  void initState() {
    super.initState();
    selectedProducts = List.from(widget.selectedProducts);
    while (selectedProducts.length < 3) {
      selectedProducts.add(null);
    }
  }

  void _removeProduct(int index) {
    final nonNullCount = selectedProducts.where((e) => e != null).length;
    if (nonNullCount > 1) {
      setState(() {
        selectedProducts[index] = null;
      });
    }
  }

  void _addProduct(int index) {
    print("Navigate to add product at index $index");
  }

  @override
  Widget build(BuildContext context) {
    final productCount = selectedProducts.where((e) => e != null).length;

    return Scaffold(
      appBar: AppBar(title: const Text("Compare Products")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
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
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0),
                                  child: Image.asset(
                                    product.image,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              if (productCount > 1)
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
                                      child: const Icon(Icons.close,
                                          size: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...featureList.map((feature) {
                            String value = "-";
                            switch (feature['key']) {
                              case 'price':
                                value = "₹${product.price}";
                                break;
                              case 'ram':
                                value = "6GB";
                                break;
                              case 'rom':
                                value = "128GB";
                                break;
                              case 'display':
                                value = "6.5-inch AMOLED";
                                break;
                              case 'battery':
                                value = "5000mAh";
                                break;
                              case 'frontCamera':
                                value = "16MP";
                                break;
                              case 'rearCamera':
                                value = "64MP + 8MP + 2MP";
                                break;
                              case 'processor':
                                value = "Snapdragon 778G";
                                break;
                            }
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.grey.shade200),
                                ),
                                color: Colors.blue.shade50,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feature['label']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    value,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      )
                    : (productCount == 1 && index == 1)
                        ? GestureDetector(
                            onTap: () => _addProduct(index),
                            child: Container(
                              height: 300,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(12),
                              child: FittedBox(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorConstants.appBlueColor3,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.add,
                                          color: Colors.white, size: 18),
                                      SizedBox(width: 6),
                                      Text(
                                        "Add Product",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(height: 300),
              ),
            );
          }),
        ),
      ),
    );
  }
}
