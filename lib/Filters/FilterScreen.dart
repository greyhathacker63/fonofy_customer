
import 'package:flutter/material.dart';
import 'package:fonofy/model/common_filter_model.dart';
 import 'package:fonofy/widgets/Colors.dart';
import 'package:http/http.dart' as http;

import '../Api_Service/FilterService.dart';


class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedCategory = "Price";

  CommonFilterModel? commonFilters;

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
    "Brand": <String>{},
  };

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  final filterService = FilterService();

  @override
  void initState() {
    super.initState();
    fetchCommonFilters();
  }

  Future<void> fetchCommonFilters() async {
    final data = await filterService.fetchCommonFilterData();
    if (data != null) {
      setState(() {
        commonFilters = data;
      });
    }
  }

  void toggleSelection(String category, String value) {
    setState(() {
      if (selectedFilters[category].contains(value)) {
        selectedFilters[category].remove(value);
      } else {
        selectedFilters[category].add(value);
      }
    });
  }

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

  Widget buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Price Range", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Min", border: OutlineInputBorder()),
                onChanged: (value) => selectedFilters["Price"]["min"] = value,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Max", border: OutlineInputBorder()),
                onChanged: (value) => selectedFilters["Price"]["max"] = value,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCheckboxFilter(String category, List<String> options) {
    return Expanded(
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return CheckboxListTile(
            title: Text(option),
            value: selectedFilters[category]?.contains(option) ?? false,
            onChanged: (isSelected) => toggleSelection(category, option),
          );
        },
      ),
    );
  }

  List<String> getOptionsForCategory(String category) {
    switch (category) {
      case "RAM":
        return commonFilters?.rams.map((e) => e.ramName).toList() ?? [];
      case "ROM":
        return commonFilters?.roms.map((e) => e.romName).toList() ?? [];
      case "Display":
        return commonFilters?.displays.map((e) => e.display).toList() ?? [];
      case "Battery":
        return commonFilters?.batteries.map((e) => e.battery).toList() ?? [];
      case "Front Camera":
        return commonFilters?.frontCameras.map((e) => e.frontCamera).toList() ?? [];
      case "Rear Camera":
        return commonFilters?.rearCameras.map((e) => e.rearCamera).toList() ?? [];
      case "Processor":
        return commonFilters?.processors.map((e) => e.processor).toList() ?? [];
      case "Color":
        return commonFilters?.colors.map((e) => e.colorName).toList() ?? [];
      case "Brand":
        return commonFilters?.brands.map((e) => e.brandName).toList() ?? [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Price", "RAM", "ROM", "Display", "Battery", "Front Camera",
      "Rear Camera", "Processor", "Color", "Brand"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          TextButton(
            onPressed: clearFilters,
            child: const Text("Clear Filters", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.appBlueColor3,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            Navigator.pop(context, selectedFilters);
          },
          child: const Text("Apply", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      body: commonFilters == null
          ? const Center(child: CircularProgressIndicator())
          : Row(
        children: [
          // Category Sidebar
          Container(
            width: 120,
            color: Colors.grey[200],
            child: ListView(
              children: categories.map((category) {
                return ListTile(
                  title: Text(category, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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

          // Filter Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedCategory, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Divider(),
                  if (selectedCategory == "Price")
                    buildPriceFilter()
                  else
                    buildCheckboxFilter(selectedCategory, getOptionsForCategory(selectedCategory)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
