import 'package:flutter/material.dart';
import 'package:fonofy/models/CommonFilterModel/CommonFilterModel.dart';
import 'package:fonofy/pages/ProductScreen/ProductScreen.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';
import '../../Api_Service/FilterService/FilterService.dart';

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
  final FilterService filterService = FilterService();

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

  void toggleSelection(String category, String value, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedFilters[category].add(value);
      } else {
        selectedFilters[category].remove(value);
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
                onChanged: (value) {
                  selectedFilters["Price"]["min"] = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: maxPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Max", border: OutlineInputBorder()),
                onChanged: (value) {
                  selectedFilters["Price"]["max"] = value;
                  setState(() {});
                },
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
            onChanged: (bool? isSelected) {
              if (isSelected != null) {
                toggleSelection(category, option, isSelected);
              }
            },
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
      "Price",
      "RAM",
      "ROM",
      "Display",
      "Battery",
      "Front Camera",
      "Rear Camera",
      "Processor",
      "Color",
      "Brand",
    ];
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Filters"),
        actions: [
          TextButton(
            onPressed: clearFilters,
            child: const Text("Clear Filters", style: TextStyle(color: Colors.blue)),
          ),
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
            final simplifiedFilters = {
              'ram': selectedFilters['RAM'].isNotEmpty ? selectedFilters['RAM'].join(',') : '',
              'rom': selectedFilters['ROM'].isNotEmpty ? selectedFilters['ROM'].join(',') : '',
              'brand': selectedFilters['Brand'].isNotEmpty ? selectedFilters['Brand'].join(',') : '',
              'color': selectedFilters['Color'].isNotEmpty ? selectedFilters['Color'].join(',') : '',
              'display': selectedFilters['Display'].isNotEmpty ? selectedFilters['Display'].join(',') : '',
              'battery': selectedFilters['Battery'].isNotEmpty ? selectedFilters['Battery'].join(',') : '',
              'front': selectedFilters['Front Camera'].isNotEmpty ? selectedFilters['Front Camera'].join(',') : '',
              'rear': selectedFilters['Rear Camera'].isNotEmpty ? selectedFilters['Rear Camera'].join(',') : '',
              'processor': selectedFilters['Processor'].isNotEmpty ? selectedFilters['Processor'].join(',') : '',
              'minAmt': selectedFilters['Price']['min']?.isNotEmpty == true ? selectedFilters['Price']['min'] : '',
              'underAmt': selectedFilters['Price']['max']?.isNotEmpty == true ? selectedFilters['Price']['max'] : '',
            };
            Navigator.pop(context, simplifiedFilters);
          },
          child: const Text("Apply", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
      body: commonFilters == null
          ? const Center(child: CircularProgressIndicator())
          : Row(
        children: [
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