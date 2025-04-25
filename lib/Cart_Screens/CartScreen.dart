import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/AddToCartService/AddToCartService.dart';
import 'package:fonofy/Api_Service/AddToCartService/ShippingChargeService.dart';
import 'package:fonofy/Cart_Screens/CheckoutScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/AddToCartModel/CartListModel.dart';
import 'package:fonofy/model/AddToCartModel/ShippingChargeModel.dart';
import 'package:fonofy/model/DataObject.dart';
import 'package:get/get.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../model/AddToCartModel/AddToCartModel.dart';
import '../utils/Colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  double unitPrice = 0.0;
  double shippingCost = 0.0;

  AddToCartModel? addToCartItems;
  ShippingChargeModel? shippingChargeData;

  List<CartListModel> cartList = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems();
    fetchShippingData();
  }

  Future<void> fetchCartItems() async {
    try {
      String? userCode = await TokenHelper.getUserCode();
      if (userCode != null) {
        final response = await AddToCartService.fetchAddToCartData(userCode);
        setState(() {
          addToCartItems = response;
        });
      }
    } catch (e) {
      print("❌ Error fetching cart items: $e");
    }
  }
  Future<void> fetchShippingData() async {
    try {
      var data = await ShippingChargeService.fetchShippingCharge();
      if (data != null) {
        setState(() {
          shippingChargeData = data;
        });
      }
    } catch (e) {
      print("❌ Error fetching shipping charge: $e");
    }
  }

  void updateQuantity(bool isIncrement) {
    int maxQty = addToCartItems?.result?.quantity ?? 1;

    if (isIncrement) {
      if (quantity < maxQty) {
        setState(() {
          quantity++;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You can only add up to $maxQty item(s)."),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      if (quantity > 1) {
        setState(() {
          quantity--;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Minimum quantity is 1."),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  double calculateShippingCharge(double totalAmount) {
    if (shippingChargeData == null) {
      return 0.0;
    }

    if (totalAmount >= (shippingChargeData?.maxAmount ?? 0)) {
      int multiples = (totalAmount / (shippingChargeData?.maxAmount ?? 1)).floor();
      return multiples * (shippingChargeData?.shippingCharge ?? 0);
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic price = DataClass.sellingPrice;
    dynamic shipping = DataClass.shipping;
    unitPrice = double.tryParse(price.toString()) ?? 0.0;
    shippingCost = double.tryParse(shipping.toString()) ?? 0.0;

    double subtotal = unitPrice * quantity;
    double shippingCharge = calculateShippingCharge(subtotal);
    double total = subtotal + shippingCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "There are product(s) in your cart",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "$imageAllBaseUrl${DataClass.imageUrl ?? ''}",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DataClass.productName ?? 'No Name'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "₹${unitPrice.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () => updateQuantity(false),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () => updateQuantity(true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        quantity = 0;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  _summaryRow("Subtotal", "₹${subtotal.toStringAsFixed(1)}"),
                  _divider(),
                  _summaryRow("Shipping Charge", "₹${shippingCharge.toStringAsFixed(1)}"),
                  _divider(),
                  _summaryRow("Total", "₹${total.toStringAsFixed(1)}", isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => CheckoutScreen());
              },
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: const Text("Proceed to Checkout", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              label: const Text("Continue Shopping", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.appBlueColor3,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(color: Colors.grey);
  }
  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
