import 'package:flutter/material.dart';

void showSortBySheet(BuildContext context, Function(String) onSortSelected) {
  String? selectedSort; // ✅ Declare outside so it retains state

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // ✅ Keeps bottom sheet open
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "SORT BY",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),

                _buildSortOption("Price -- Low to High", selectedSort, setState, (newSort) {
                  setState(() {
                    selectedSort = newSort; // ✅ Updates selection
                  });
                  onSortSelected(newSort); // ✅ Sends selection back
                }),

                _buildSortOption("Price -- High to Low", selectedSort, setState, (newSort) {
                  setState(() {
                    selectedSort = newSort;
                  });
                  onSortSelected(newSort);
                }),

                _buildSortOption("Newest First", selectedSort, setState, (newSort) {
                  setState(() {
                    selectedSort = newSort;
                  });
                  onSortSelected(newSort);
                }),

                const SizedBox(height: 20),

                // ✅ Close Button
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // Manually close
                  child: const Text("Done"),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _buildSortOption(
  String title,
  String? selectedSort,
  Function(void Function()) setState,
  Function(String) onTap,
) {
  return ListTile(
    title: Text(title, style: const TextStyle(fontSize: 16)),
    trailing: Radio<String>(
      value: title,
      groupValue: selectedSort,
      onChanged: (value) {
        setState(() {
          onTap(value!); // ✅ Updates state when radio is clicked
        });
      },
    ),
    onTap: () {
      setState(() {
        onTap(title); // ✅ Updates when tapped
      });
    },
  );
}
