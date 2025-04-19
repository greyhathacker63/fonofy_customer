import 'package:flutter/material.dart';
import 'package:fonofy/widgets/Colors.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
  List<String> paymentMethods = [
  
    'Credit/Debit Cards',
    'Bank Transfers',
    'Mobile Payments',
    'Digital Wallets',
  ];

  String selectedPaymentMethod = 'Cash on Delivery';
}
List<String> paymentMethods = [
  'Cash on Delivery',
  'Credit/Debit Cards',
  'Bank Transfers',
  'Mobile Payments',
  'Digital Wallets',
];

String selectedPaymentMethod = 'Cash on Delivery';

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Map<String, String>> addresses = [
    {
      'name': 'John Doe',
      'address': '123, MG Road, Mumbai - 400001',
      'phone': '9876543210',
    },
    {
      'name': 'Jane Smith',
      'address': '55, Park Street, Delhi - 110001',
      'phone': '9988776655',
    },
  ];

  int selectedAddressIndex = 0;

  void _addNewAddress(String name, String address, String phone) {
    setState(() {
      addresses.add({'name': name, 'address': address, 'phone': phone});
      selectedAddressIndex = addresses.length - 1;
    });
  }

  void _showAddAddressDialog() {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add New Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name")),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address")),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone")),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              _addNewAddress(nameController.text, addressController.text,
                  phoneController.text);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  void _editAddress(int index) {
    final nameController =
        TextEditingController(text: addresses[index]['name']);
    final addressController =
        TextEditingController(text: addresses[index]['address']);
    final phoneController =
        TextEditingController(text: addresses[index]['phone']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name")),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address")),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone")),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                addresses[index] = {
                  'name': nameController.text,
                  'address': addressController.text,
                  'phone': phoneController.text,
                };
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  Widget _buildAddressTile(Map<String, String> address, int index) {
    return Dismissible(
      key: ValueKey(address),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.blue,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          _editAddress(index);
          return false;
        } else {
          return true;
        }
      },
      onDismissed: (direction) {
        setState(() => addresses.removeAt(index));
      },
      child: ListTile(
        leading: Radio<int>(
          value: index,
          groupValue: selectedAddressIndex,
          onChanged: (value) => setState(() => selectedAddressIndex = value!),
        ),
        title: Text(address['name'] ?? ''),
        subtitle: Text("${address['address']}\nPhone: ${address['phone']}"),
        isThreeLine: true,
      ),
    );
  }

  final Map<String, dynamic> product = {
    "name": "Apple iPhone 13",
    "price": 49999,
    "image": "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-13-01.jpg",
    "variant": "Superb • 128GB • Black"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Summary
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product["image"],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(product["variant"],
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text("₹${product["price"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Address Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Delivery Address",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextButton(
                  onPressed: _showAddAddressDialog,
                  child: const Text("+ Add New Address"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 140,
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (_, index) =>
                    _buildAddressTile(addresses[index], index),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Payment Method Section
            const Text("Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPaymentMethod,
                  isExpanded: true,
                  items: paymentMethods.map((String method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(method,
                          style: const TextStyle(color: Colors.black87)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Price Summary
            const Text("Price Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Column(
              children: [
                _priceRow("Item Price", product["price"]),
                _priceRow("Delivery Charges", 99),
                const Divider(),
                _priceRow("Total", product["price"] + 99,
                    isBold: true, isTotal: true),
              ],
            ),
            const SizedBox(height: 16),

            // Place Order Button
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Order Placed", "Your order has been confirmed!",
                    snackPosition: SnackPosition.BOTTOM);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Place Order",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, int amount,
      {bool isBold = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isTotal ? 16 : 14)),
          Text("₹$amount",
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isTotal ? 16 : 14)),
        ],
      ),
    );
  }
}
