import 'package:flutter/material.dart';
import 'package:fonofy/controllers/Controller.dart';
import 'package:fonofy/model/RamModel.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/RomModel.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final Controller dashboardController = Get.put(Controller());
  String selectedCategory = "Price";

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

  final Map<String, dynamic> filterOptions = {
    "Price": {"min": "", "max": ""},
    "RAM": [], // Loaded dynamically via GetX
    "ROM": [], // Loaded dynamically
    "Display": ["5.5 inch", "6.0 inch", "6.5 inch", "6.7 inch"],
    "Battery": ["3000mAh", "4000mAh", "5000mAh", "6000mAh"],
    "Front Camera": ["8MP", "12MP", "16MP", "32MP"],
    "Rear Camera": ["12MP", "48MP", "64MP", "108MP"],
    "Processor": ["Snapdragon 695", "MediaTek Dimensity 810", "Exynos 1280"],
    "Color": ["Black", "Blue", "Green", "Red", "White"],
  };

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

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

  Future<void> fetchRomList() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.fonofy.in/api/common/rom-list'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<String> romNames =
            data.map((e) => RomModel.fromJson(e).romName).toList();

        setState(() {
          filterOptions["ROM"] = romNames;
        });
      } else {
        print("Failed to load ROMs: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching ROMs: $e");
    }
  }

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

  Widget buildStaticCheckboxFilter({
    required List<String> filterData,
    required String category,
  }) {
    return Expanded(
      child: ListView.builder(
        itemCount: filterData.length,
        itemBuilder: (context, index) {
          final option = filterData[index];
          return CheckboxListTile(
            title: Text(option),
            value: selectedFilters[category]?.contains(option) ?? false,
            onChanged: (isSelected) => toggleSelection(category, option),
          );
        },
      ),
    );
  }

  Widget buildCheckboxFilter({
    required List<RamModel> filterData,
    required String category,
  }) {
    return Expanded(
      child: ListView.builder(
        itemCount: filterData.length,
        itemBuilder: (context, index) {
          final option = filterData[index].ramName ?? '';
          return CheckboxListTile(
            title: Text(option),
            value: selectedFilters[category]?.contains(option) ?? false,
            onChanged: (isSelected) => toggleSelection(category, option),
          );
        },
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
          child: const Text("Apply",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      body: Row(
        children: [
          // Left Filter Categories
          Container(
            width: 120,
            color: Colors.grey[200],
            child: ListView(
              children: filterOptions.keys.map((category) {
                return ListTile(
                  title: Text(
                    category,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  selected: selectedCategory == category,
                  selectedTileColor: Colors.white,
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });

                    if (category == "ROM" &&
                        (filterOptions["ROM"]?.isEmpty ?? true)) {
                      fetchRomList();
                    }
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
                  if (selectedCategory == "Price") ...[
                    buildPriceFilter()
                  ] else if (selectedCategory == "RAM") ...[
                    Obx(() {
                      if (dashboardController.ramDataLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: ColorConstants.appBlueColor3),
                        );
                      }

                      final ramList = dashboardController.getRamData ?? [];

                      if (ramList.isEmpty) {
                        return const Text("No RAM options available.");
                      }

                      return buildCheckboxFilter(
                        filterData: ramList,
                        category: selectedCategory,
                      );
                    })
                  ] else ...[
                    buildStaticCheckboxFilter(
                      filterData: List<String>.from(
                          filterOptions[selectedCategory] ?? []),
                      category: selectedCategory,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
