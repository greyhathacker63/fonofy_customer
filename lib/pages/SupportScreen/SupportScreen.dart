import 'package:flutter/material.dart';
import 'package:fonofy/widgets/ColorConstants/Colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Support"),
        backgroundColor: Colors.white, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Contact Us Header with Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Image.asset(
                        "assets/images/Logo.png",
                        height: 40, 
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),

                  /// Email Contact
                  Row(
                    children: [
                      Icon(Icons.email, color: ColorConstants.appBlueColor3),
                      SizedBox(width: 10),
                      Text(
                        "support@fonofy.com",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  /// Phone Contact
                  Row(
                    children: [
                      Icon(Icons.phone, color: ColorConstants.appBlueColor3),
                      SizedBox(width: 10),
                      Text(
                        "011123456",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
