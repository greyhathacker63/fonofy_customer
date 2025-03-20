import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy cart items
    final List<Map<String, dynamic>> cartItems = [
      {"name": "OnePlus 11r 5G", "price": 34999, "image": "assets/images/Phone3.png"},
      {"name": "Screen Replacement", "price": 8999, "image": "assets/images/Screen2.png"},
      {"name": "Battery Replacement", "price": 2702, "image": "assets/images/Battery.png"},
    ];

    // Calculate total price
    double totalPrice = cartItems.fold(0, (sum, item) => sum + item["price"]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black), // Back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(cartItems[index]["image"], height: 50),
                      title: Text(cartItems[index]["name"]),
                      subtitle: Text("₹${cartItems[index]["price"]}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Handle item removal
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1),

            // Total Price
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("₹$totalPrice", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),

            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Handle checkout logic
                },
                child: const Text("Checkout", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
