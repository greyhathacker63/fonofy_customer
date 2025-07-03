import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Refurb Category"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mobileGrades(),
            const SizedBox(height: 20),
            warrantyGrades(),
            const SizedBox(height: 20),
            laptopGrades(),
            const SizedBox(height: 20),
            infoOptions(),
          ],
        ),
      ),
    );
  }

  // **Mobile Grades**
  Widget mobileGrades() {
    List<Map<String, dynamic>> mobileGradeList = [
      {"title": "F1+", "color": Colors.blue[100]},
      {"title": "F1", "color": Colors.green[100]},
      {"title": "F2", "color": Colors.orange[100]},
    ];

    return _buildGradeSection("Mobile Grades", mobileGradeList);
  }

  // **Warranty Grades**
  Widget warrantyGrades() {
    List<Map<String, dynamic>> warrantyGradeList = [
      {"title": "Superb", "color": Colors.blue[100]},
      {"title": "Good", "color": Colors.green[100]},
      {"title": "Fair", "color": Colors.orange[100]},
    ];

    return _buildGradeSection("Warranty Grades", warrantyGradeList);
  }

  // **Laptop Grades**
  Widget laptopGrades() {
    List<Map<String, dynamic>> laptopGradeList = [
      {"title": "A", "color": Colors.blue[100]},
      {"title": "B+", "color": Colors.green[100]},
      {"title": "B", "color": Colors.orange[100]},
    ];

    return _buildGradeSection("Laptop Grades", laptopGradeList);
  }

  // **Reusable ListView for Grades**
  Widget _buildGradeSection(String title, List<Map<String, dynamic>> grades) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "More →",
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100, // Adjust height for cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: grades.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: grades[index]['color'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          grades[index]['title'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.arrow_forward, size: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // **Info Options with Rectangular Containers**
  Widget infoOptions() {
    List<Map<String, dynamic>> options = [
      {"title": "Super Sales Loyalty Program", "icon": Icons.star},
      {"title": "FAQ", "icon": Icons.help_outline},
      {"title": "Return Policy", "icon": Icons.policy},
      {"title": "Grading Info", "icon": Icons.info_outline},
      {"title": "Laptop Return Policy", "icon": Icons.laptop},
      {"title": "Laptop Grading Info", "icon": Icons.assignment},
      {"title": "Contact Info", "icon": Icons.contact_mail},
    ];

    return Column(
      children: options.map((option) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(option["icon"], color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option["title"],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        );
      }).toList(),
    );
  }
}
