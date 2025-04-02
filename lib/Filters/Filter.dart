import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Colors.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Selected Category (Default: Price)
  String selectedCategory = "Price";

  // Selected Filters Storage
  Map<String, dynamic> selectedFilters = {
    "Price": {"min": "", "max": ""},
    "RAM": <String>{},
    "ROM": <String>{},
    "Display": <String>{},
    "Battery": <String>{},
    "Front Camera": <String>{},
    "Rear Camera": <String>{},
    "Processor": <String>{},
    "Color": <String>{},
  };

  // Filter Options Data
  final Map<String, dynamic> filterOptions = {
    "Price": {"min": "", "max": ""},
    "RAM": ["4GB", "6GB", "8GB", "12GB"],
    "ROM": ["32GB", "64GB", "128GB", "256GB", "512GB"],
    "Display": ["5.5 inch", "6.0 inch", "6.5 inch", "6.7 inch"],
    "Battery": ["3000mAh", "4000mAh", "5000mAh", "6000mAh"],
    "Front Camera": ["8MP", "12MP", "16MP", "32MP"],
    "Rear Camera": ["12MP", "48MP", "64MP", "108MP"],
    "Processor": ["Snapdragon 695", "MediaTek Dimensity 810", "Exynos 1280"],
    "Color": ["Black", "Blue", "Green", "Red", "White"],
  };

  // Controllers for Price Min & Max
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  // Toggle Filter Selection (Checkbox)
  void toggleSelection(String category, String value) {
    setState(() {
      if (selectedFilters[category].contains(value)) {
        selectedFilters[category].remove(value);
      } else {
        selectedFilters[category].add(value);
      }
    });
  }

  // Clear Filters
  void clearFilters() {
    setState(() {
      for (var key in selectedFilters.keys) {
        if (key == "Price") {
          selectedFilters[key]["min"] = "";
          selectedFilters[key]["max"] = "";
          minPriceController.clear();
          maxPriceController.clear();
        } else {
          selectedFilters[key].clear();
        }
      }
    });
  }

  // Widget for Price Filter
  Widget buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price Range",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Min Price TextField
            Expanded(
              child: TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Min",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => selectedFilters["Price"]["min"] = value,
              ),
            ),
            const SizedBox(width: 10),
            // Max Price TextField
            Expanded(
              child: TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Max",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => selectedFilters["Price"]["max"] = value,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget for Checkbox Filters
  Widget buildCheckboxFilter(String category) {
    return Expanded(
      child: ListView(
        children: filterOptions[category].map<Widget>((option) {
          return CheckboxListTile(
            title: Text(option),
            value: selectedFilters[category].contains(option),
            onChanged: (isSelected) => toggleSelection(category, option),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          TextButton(
            onPressed: clearFilters,
            child: const Text("Clear Filters",
                style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: Row(
        children: [
          // Left Navigation List
          Container(
            width: 120,
            color: Colors.grey[200],
            child: ListView(
              children: filterOptions.keys.map((category) {
                return ListTile(
                  title: Text(category,
                      style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  selected: selectedCategory == category,
                  selectedTileColor: Colors.white,
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
          ),

          // Right Filter Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedCategory,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),

                  // Show Price Filter or Checkbox Filters
                  selectedCategory == "Price"
                      ? buildPriceFilter()
                      : buildCheckboxFilter(selectedCategory),
                ],
              ),
            ),
          ),
        ],
      ),

      // Apply Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.appBlueColor3,
              padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed: () {
            // Handle filter apply logic
            Navigator.pop(context, selectedFilters);
          },
          child: const Text("Apply",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}
