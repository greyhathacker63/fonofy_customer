import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import 'OrderRepairDetailsScreen.dart';

class RepairOrderScreen extends StatelessWidget {
  const RepairOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Repair Order")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: ColorConstants.appBlueColor3, size: 18),
                        const SizedBox(width: 6),
                        const Text("Order Failed",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                          SizedBox(width: 10),
                         Text("04 Jun 2025",
                          style: TextStyle(color: Colors.grey,fontSize: 12),
                        ),
                      ],
                    ),
                    Container(
                      padding:EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: ColorConstants.appBlueColor3,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("REPAIR",
                        style: TextStyle(color: Colors.white,fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network('https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                            width: 70,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 70,
                                height: 90,
                                color: Colors.grey.shade300,
                                child: Icon(Icons.image, size: 40, color: ColorConstants.appBlueColor3),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade100,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child:Text('2 Part(s)',
                            style: TextStyle(fontSize: 10, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Order ID: CSPATOI726107",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Vivo X70 Pro",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Cosmic Black",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Wrap icon to avoid overflow
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRepairDetailsScreen())
                         );
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
                      ),
                    ),


                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  "Booked Repair Services",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 8),

                _buildServiceRow("BATTERY", "₹2,999"),
                _buildServiceRow("SCREEN", "₹10,999"),

                const Divider(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Repair Amount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹13,998",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceRow(String serviceName, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(serviceName, style: const TextStyle(fontSize: 14)),
          Text(price, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
