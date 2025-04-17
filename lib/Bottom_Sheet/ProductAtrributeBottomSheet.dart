import 'package:flutter/material.dart';

class ProductAttributeBottomSheet extends StatefulWidget {
  const ProductAttributeBottomSheet({super.key});

  @override
  _ProductAttributeBottomSheetState createState() =>
      _ProductAttributeBottomSheetState();
}

class _ProductAttributeBottomSheetState
    extends State<ProductAttributeBottomSheet> {
  // LOCAL STATE
  String selectedCondition = "Fair";
  String selectedStorage = "4 GB / 128 GB";
  int selectedColorIndex = 4;
  bool showDealsOnly = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Apple iPhone 13 - Refurbished",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              const SizedBox(height: 8),
              Text(
                "$selectedCondition / $selectedStorage / Color ${selectedColorIndex + 1}",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "₹31,499 ",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: " ₹59,900 ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                    TextSpan(
                      text: "  You Save ₹28,401",
                      style: TextStyle(fontSize: 14, color: Colors.green[700]),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// CONDITION
              _sectionTitle("Condition"),
              Wrap(
                spacing: 8,
                children: ["Fair", "Good", "Superb"].map((condition) {
                  return ChoiceChip(
                    label: Text(condition),
                    selected: selectedCondition == condition,
                    onSelected: (_) {
                      setState(() => selectedCondition = condition);
                    },
                    selectedColor: Colors.teal.shade100,
                    labelStyle: TextStyle(
                      color: selectedCondition == condition
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),

              Row(
                children: [
                  Checkbox(
                    value: showDealsOnly,
                    onChanged: (val) => setState(() => showDealsOnly = val ?? false),
                  ),
                  const Text("Show deals only"),
                ],
              ),

              const SizedBox(height: 10),
              _buildWarrantyCard(),

              const SizedBox(height: 20),
              _sectionTitle("Storage"),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ["4 GB / 128 GB", "4 GB / 256 GB", "4 GB / 512 GB"]
                    .length,
                itemBuilder: (context, index) {
                  String storage = ["4 GB / 128 GB", "4 GB / 256 GB", "4 GB / 512 GB"][index];
                  bool isSelected = selectedStorage == storage;
                  return OutlinedButton(
                    onPressed: () {
                      setState(() => selectedStorage = storage);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isSelected ? Colors.teal : Colors.grey),
                      backgroundColor: isSelected ? Colors.teal.shade50 : null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          storage,
                          style: TextStyle(
                              color: isSelected ? Colors.teal : Colors.black),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.check, color: Colors.teal, size: 18)
                        ]
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              _sectionTitle("Color"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 14,
                runSpacing: 12,
                children: List.generate(6, (index) {
                  bool isSelected = selectedColorIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedColorIndex = index),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.primaries[
                                      index % Colors.primaries.length]
                                  .shade400,
                              child: isSelected
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                            Positioned(
                              bottom: -12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text("₹5,700 off",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Buy Now", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );

  Widget _buildWarrantyCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.teal),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Add ",
                      children: [
                        TextSpan(
                          text: "6 Months",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " extended warranty at ₹899"),
                      ],
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "All devices have a default 6 Months warranty out of the box",
              style: TextStyle(color: Colors.teal, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
