import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/ListShippingAddressService.dart';
import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';
import 'package:fonofy/Manage%20Address/ManageAddressScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/AddToCartModel/CartListModel.dart';
import 'package:fonofy/model/ShippingAddressModel/ListShippingAddressModel.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:shimmer/shimmer.dart';

import '../Api_Service/ShippingAddressService/DeleteShippingAddressService.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartListModel>? cartList;
  final double? totalAmount;
  final bool isSingleProduct;

  // Single product fields
  final String? modelNo;
  final String? colorId;
  final String? stockQuantity;
  final double? price;
  final String? productImage;
  final String? userCode;
  final String? productName;
  final String? ramName;
  final String? romName;
  final String? colorName;
  final String? ramId;
  final String? romId;
  final double? newModelAmt;

  const CheckoutScreen({
    super.key,
    this.cartList,
    this.totalAmount,
    this.isSingleProduct = false,
    this.modelNo,
    this.colorId,
    this.stockQuantity,
    this.price,
    this.productImage,
    this.userCode,
    this.productName,
    this.ramName,
    this.romName,
    this.colorName,
    this.ramId,
    this.romId,
    this.newModelAmt,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Future<List<ListShippingAddressModel>> _addressFuture;

  String token = "";
  int selectedAddressIndex = -1;

  List<String> paymentMethods = [
    'Cash on Delivery',
    'Credit/Debit Cards',
    'Bank Transfers',
    'Mobile Payments',
    'Digital Wallets',
  ];
  String selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    String? storedToken = await TokenHelper.getToken();
    String? userCode = widget.userCode ?? await TokenHelper.getUserCode();
    if (storedToken != null && storedToken.isNotEmpty && userCode != null) {
      token = storedToken;
      _addressFuture = ListShippingAddressService().listShippingAddress(
        customerId: userCode,
        token: token,
      );
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to continue")),
      );
    }
  }

  void _navigateToAddNewAddressScreen() async {
    String? userCode = widget.userCode ?? await TokenHelper.getUserCode();
    if (userCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewAddressScreen(
          customerId: userCode,
          address: ListShippingAddressModel(),
        ),
      ),
    );
    if (result != null) {
      setState(() {
        selectedAddressIndex = -1; // Reset selection on new address addition
        _initializeData();
      });
    }
  }

  Widget _buildAddressTile(ListShippingAddressModel address, int index) {
    return Dismissible(
      key: ValueKey(address.id ?? index),
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

          String? userCode = widget.userCode ?? await TokenHelper.getUserCode();


          if (userCode == null) return false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewAddressScreen(customerId: userCode, address: address,
              ),
            ),
          );
          return false;
        } else {
          // Delete
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Delete Address"),
              content:
                  const Text("Are you sure you want to delete this address?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Delete"),
                ),
              ],
            ),
          );
          if (confirm == true) {
            final id = address.id;
            final shipmentId = address.shippmentId;
            if (id != null && shipmentId != null && shipmentId.isNotEmpty) {
              final result = await DeleteAddressService.deleteAddress(
                id: id,
                shipmentId: shipmentId,
              );
              if (result != null && result.status == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("✅ ${result.message}")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(result?.message ?? "Deleted successfully")),
                );
              }

              setState(() {
                _addressFuture =
                    ListShippingAddressService().listShippingAddress(
                  customerId: widget.userCode ?? '',
                  token: token,
                );
              });

              return true;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("❌ Invalid ID or Shipment ID")),
              );
              return false;
            }
          }

          return false;
        }
      },
      onDismissed: (direction) {
        setState(() {
          if (selectedAddressIndex == index) {
            selectedAddressIndex = -1;
          } else if (selectedAddressIndex > index) {
            selectedAddressIndex--;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Address ${address.city} deleted")),
        );
      },
      child: ListTile(
        leading: Radio<int>(
          value: index,
          groupValue: selectedAddressIndex,
          onChanged: (value) {
            setState(() {
              selectedAddressIndex = value!;
              print("Selected Address Index: $selectedAddressIndex");
            });
          },
        ),
        title:
            Text("Name: ${address.name ?? 'NA'} | ${address.workType ?? 'NA'}"),
        subtitle: Text(
          "${address.address ?? 'NA'}\n${address.city ?? 'NA'} - ${address.pinCode ?? 'NA'}\nPhone: ${address.mobileNo ?? 'NA'}",
        ),
        isThreeLine: true,
      ),
    );
  }

  double _calculateSubtotal() {
    if (widget.isSingleProduct) {
      return widget.price ?? 0.0;
    }
    return widget.cartList?.fold(0.0, (sum, item) {
          double price =
              double.tryParse(item.sellingPrice?.toString() ?? '0') ?? 0.0;
          return sum! + (price * item.quantity);
        }) ??
        0.0;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isSingleProduct &&
        (widget.cartList == null || widget.cartList!.isEmpty)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: const Center(child: Text("Your cart is empty!")),
      );
    }

    if (widget.isSingleProduct &&
        (widget.productName == null ||
            widget.price == null ||
            widget.productImage == null)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: const Center(child: Text("Invalid product details!")),
      );
    }

    double subtotal = _calculateSubtotal();
    double shippingCharge = 99.0;
    double total = subtotal + shippingCharge;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Summary
                    const Text(
                      "    Order Summary",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    widget.isSingleProduct
                        ? _buildSingleProductSummary()
                        : _buildCartProductsSummary(),
                    const SizedBox(height: 24),
                    // Address Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Text(
                            "Delivery Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: _navigateToAddNewAddressScreen,
                          child: const Text(
                            "+ Add New Address",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    FutureBuilder<List<ListShippingAddressModel>>(
                      future: _addressFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            itemCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, i) => _buildShimmerEffect(),
                          );
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const Center(
                              child: Text("❌ No address found!"));
                        } else if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("📭 No addresses available."));
                        }
                        var addresses = snapshot.data!;
                        if (selectedAddressIndex == -1 &&
                            addresses.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              selectedAddressIndex = 0;
                              print("Default Address Selected: Index 0");
                            });
                          });
                        }
                        if (selectedAddressIndex >= addresses.length) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              selectedAddressIndex =
                                  addresses.isNotEmpty ? 0 : -1;
                              print(
                                  "Adjusted Invalid Index to: $selectedAddressIndex");
                            });
                          });
                        }
                        print(
                            "Address List Length: ${addresses.length}, Selected Index: $selectedAddressIndex");
                        return ListView.builder(
                          itemCount: addresses.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) =>
                              _buildAddressTile(addresses[index], index),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Payment Method Section
                    const Text(
                      "Payment Method",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
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
                                  style:
                                      const TextStyle(color: Colors.black87)),
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
                    const Text(
                      "Price Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        _priceRow("Subtotal", subtotal),
                        _priceRow("Delivery Charges", shippingCharge),
                        const Divider(),
                        _priceRow("Total", total, isBold: true, isTotal: true),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Place Order Button
                    ElevatedButton(
                      onPressed: () {
                        if (selectedAddressIndex >= 0) {
                          // TODO: Implement order placement logic
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text("Order placed successfully!")),
                          // );
                        } else {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text("Please select a delivery address")),
                          // );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.appBlueColor3,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        "Place Order",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSingleProductSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "$imageAllBaseUrl${widget.productImage}",
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  "(${widget.ramName ?? ''}/${widget.romName ?? ''}) | Color: ${widget.colorName ?? ''}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "₹${widget.price?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "₹${widget.newModelAmt?.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartProductsSummary() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.cartList!.length,
      itemBuilder: (context, index) {
        final cartItem = widget.cartList![index];
        double price =
            double.tryParse(cartItem.sellingPrice?.toString() ?? '0') ?? 0.0;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "$imageAllBaseUrl${cartItem.productImage}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.productName ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Qty: ${cartItem.quantity}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹${(price * cartItem.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 14,
                  width: index == 3 ? 100 : double.infinity,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String label, double amount,
      {bool isBold = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
