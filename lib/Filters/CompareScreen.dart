import 'package:flutter/material.dart';
import 'package:fonofy/ProductScreens/ProductScreen.dart'; 

class CompareScreen extends StatelessWidget {
  final List<Product> selectedProducts;

  const CompareScreen({Key? key, required this.selectedProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Compare Products")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: selectedProducts.map((product) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(8),
                child: Container(
                  width: 180,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        product.image,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                      Text("Price: ₹${product.price}",
                          style: const TextStyle(fontSize: 14)),

                      _buildText("RAM", product, "ram"),
                      _buildText("ROM", product, "rom"),
                      _buildText("Display", product, "display"),
                      _buildText("Battery", product, "battery"),
                      _buildText("Front Camera", product, "frontCamera"),
                      _buildText("Rear Camera", product, "rearCamera"),
                      _buildText("Processor", product, "processor"),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildText(String label, Product product, String fieldName) {
    final fieldValue = _getFieldValue(product, fieldName);
    return fieldValue != null
        ? Text("$label: $fieldValue", style: const TextStyle(fontSize: 14))
        : const SizedBox(); 
  }

 
  String? _getFieldValue(Product product, String fieldName) {
    final productMap = {
      "ram": "6GB",
      "rom": "128GB",
      "display": "6.5-inch AMOLED",
      "battery": "5000mAh",
      "frontCamera": "16MP",
      "rearCamera": "64MP + 8MP + 2MP",
      "processor": "Snapdragon 778G"
    };
    return productMap[fieldName]; 
  }
}
