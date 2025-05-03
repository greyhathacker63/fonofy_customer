 import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/AddToCartService/CartListService.dart';
import 'package:fonofy/Api_Service/AddToCartService/ShippingChargeService.dart';
import 'package:fonofy/Cart_Screens/CheckoutScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/AddToCartModel/AddToCartModel.dart';
import 'package:fonofy/model/AddToCartModel/CartListModel.dart';
import 'package:fonofy/model/AddToCartModel/DeleteCartResponseModel.dart';
import 'package:fonofy/model/AddToCartModel/ShippingChargeModel.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import '../Api_Service/AddToCartService/DeleteCartService.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartListModel> cartList = [];
  DeleteCartResponseModel? deleteCartList;
   ShippingChargeModel? shippingChargeData;
  bool isLoading = true;

  int? isDeletingIndex;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    await fetchCartList();
    await fetchShippingData();
    setState(() => isLoading = false);

  }

  Future<void> fetchCartList() async {
    try {
      final userCode = await TokenHelper.getUserCode();
      if (userCode == null || userCode.isEmpty) return;
      final response = await CartListService.fetchCartList(userCode);
      setState(() => cartList = response ?? []);
    } catch (e) {
      print("❌ Error fetching cart list: $e");
      setState(() => cartList = []);
    }
  }

  Future<void> fetchShippingData() async {
    try {
      final data = await ShippingChargeService.fetchShippingCharge();
      if (data != null) {
        setState(() => shippingChargeData = data);
      }
    } catch (e) {
      print("❌ Error fetching shipping charge: $e");
    }
  }

  double calculateSubtotal() {
    return cartList.fold(0.0, (sum, item) {
      double price = double.tryParse(item.sellingPrice?.toString() ?? '0') ?? 0.0;
      return sum + (price * item.quantity);
    });
  }

  double calculateShippingCharge(double totalAmount) {
    if (shippingChargeData == null) return 0.0;
    if (totalAmount >= (shippingChargeData?.maxAmount ?? 0)) {
      int multiples = (totalAmount / (shippingChargeData?.maxAmount ?? 1)).floor();
      return multiples * (shippingChargeData?.shippingCharge ?? 0);
    } else {
      return 0.0;
    }
  }

  Future<void> updateQuantity(bool isIncrement, int index) async {
    final int maxQty = cartList[index].stockQuantity ?? 1;
    if (isIncrement) {
      if (cartList[index].quantity < maxQty) {
        setState(() {
          cartList[index].quantity++;
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
      if (cartList[index].quantity > 1) {
        setState(() {
          cartList[index].quantity--;
        });
      } else {
        final userCode = await TokenHelper.getUserCode();
        if (userCode == null || userCode.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not logged in")),
          );
          return;
        }
        final modelNo = cartList[index].productId?.toString() ?? '';
        final ramId = cartList[index].ramId?.toString() ?? '';
        final romId = cartList[index].romId?.toString() ?? '';

        final response = await DeleteCartService.deleteCartItem(
          modelNo: modelNo,
          ramId: ramId,
          romId: romId,
          customerId: userCode,
        );

        if (response=="Product removed in cart") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response ?? 'Item removed')),
          );
          await fetchCartList();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to remove item")),
          );
        }
      }
    }
  }


  Future<void> deleteCartItemFromList(int index) async {
    final userCode = await TokenHelper.getUserCode();
    if (userCode == null || userCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      setState(() {
        isDeletingIndex = null;
      });
      return;
    }
    final modelNo = cartList[index].productId?.toString() ?? '';
    final ramId = cartList[index].ramId?.toString() ?? '';
    final romId = cartList[index].romId?.toString() ?? '';

    print("Deleting item with modelNo: $modelNo, ramId: $ramId, romId: $romId");

    final response = await DeleteCartService.deleteCartItem(modelNo: modelNo, ramId: ramId, romId: romId, customerId: userCode,
    );
    if (response == "Product removed in cart") {
      setState(() {
        cartList.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item deleted successfully')),
      );
      await fetchCartList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('$response deleted failed')),
      );

    }
    setState(() {
      isDeletingIndex = null; // stop loading
    });
  }



  @override
  Widget build(BuildContext context) {
    double subtotal = calculateSubtotal();
    double shippingCharge = calculateShippingCharge(subtotal);
    double total = subtotal + shippingCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 1, color: Colors.blue))
          : cartList.isEmpty
          ? const Center(child: Text("No items in the cart."))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartList.length,
                itemBuilder: (context, index) {
                  final cartData = cartList[index];
                  double price = double.tryParse(cartData.sellingPrice?.toString() ?? '0') ?? 0.0;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                            "$imageAllBaseUrl${cartData.productImage}",
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
                                cartData.productName ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "₹${price.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => updateQuantity(false, index),
                                  ),
                                  Text('${cartList[index].quantity}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => updateQuantity(true, index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await deleteCartItemFromList(index);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
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
                if (cartList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Your cart is empty!")),
                  );
                  return;
                }
                Get.to(() => CheckoutScreen(
                  cartList: cartList, // Pass the entire cart list
                  totalAmount: total, // Pass the total amount
                ));
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
              onPressed: () => Navigator.pop(context),
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
  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(color: Colors.grey);
}
