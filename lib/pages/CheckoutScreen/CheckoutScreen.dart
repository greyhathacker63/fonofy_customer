
import 'package:flutter/material.dart';
 import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/ListShippingAddressService.dart';
import 'package:fonofy/pages/AddNewAddressScreen/AddNewAddressScreen.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/controllers/ControllerProductDetails/GetBuyNowController.dart';
 import 'package:fonofy/models/CartListModel/CartListModel.dart';
import 'package:fonofy/models/ListShippingAddressModel/ListShippingAddressModel.dart';
 import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../Api_Service/AddToCartService/ShippingChargeService.dart';
import '../../Api_Service/ShippingAddressService/DeleteShippingAddressService.dart';
import '../AuthScreens/LoginScreen/LoginScreen.dart';
 import '../../controllers/CreateOrder/CreateOrderController.dart';
import '../../models/GetBuyNowModel/GetBuynowModel.dart';
import '../../models/ShippingChargeModel/ShippingChargeModel.dart';
import '../../models/CreateOrderModel/CreateOrderModel.dart';
import 'dart:io';

import '../../widgets/ColorConstants/Colors.dart';



class CheckoutScreen extends StatefulWidget {
  final List<CartListModel>? cartList;
  final String customerId;
  final String cartRef;
  final bool isSingleProduct;

  const CheckoutScreen({
    super.key,
    this.cartList,
    this.isSingleProduct = false,
    required this.customerId,
    required this.cartRef,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  late Future<List<ListShippingAddressModel>> _addressFuture;
  String token = "";
  final controllerGetBuy = Get.put(ControllerGetBuyNowDetails());

  final CreateOrderController orderController = Get.put(CreateOrderController());


  ListShippingAddressModel? selectedAddress;
  ShippingChargeModel? shippingChargeData;
  List<CartListModel> cartList = [];
  List<GetBuyNowModel> cartList1 = [];
  int selectedAddressIndex = 0;

  OrderProductList? orderProductList;

  List<String> paymentMethods = [
    'Cash on Delivery',
    'Credit/Debit Cards',
    // 'Bank Transfers',
    'Mobile Payments',
    'Digital Wallets',
  ];
  String selectedPaymentMethod = 'Cash on Delivery';

  @override
  void initState() {
    super.initState();
    _initializeData();
     _loadAddresses();
    fetchShippingData();
     if (widget.isSingleProduct) {
      loadBuyNowData();
    } else {
      setState(() {
        cartList = widget.cartList ?? [];
      });
    }
  }



  void loadBuyNowData() async {
    final userCode = await TokenHelper.getUserCode();
    if (userCode != null && widget.cartRef.isNotEmpty) {
      await controllerGetBuy.getGetBuyNowData(
          userCode: userCode, cartRef: widget.cartRef);
      final buyNowData = controllerGetBuy.getBuyNowDetails.value;
      if (buyNowData != null) {
        setState(() {
          cartList1 = [buyNowData];
        });
      } else {
        // print("❌ No Buy Now data received");
        Get.snackbar("Error", "Failed to load product details",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      // print("❌ Missing userCode or cartRef");
      Get.snackbar("Error", "Invalid user or cart reference",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _loadAddresses() async {
    String? userCode = await TokenHelper.getUserCode();
    String? token = await TokenHelper.getToken();
    if (userCode != null && token != null) {
      setState(() {
         _addressFuture = ListShippingAddressService().listShippingAddress(
          customerId: userCode,
          token: token,
        );
      });
    } else {
      Get.snackbar(
          "Error", "Unable to load addresses", backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> _initializeData() async {
    String? storedToken = await TokenHelper.getToken();
    String? userCode = await TokenHelper.getUserCode();
    if (storedToken != null && storedToken.isNotEmpty && userCode != null) {
      token = storedToken;
      setState(() {
        _addressFuture = ListShippingAddressService().listShippingAddress(
          customerId: userCode,
          token: token,
        );
      });
    } else {
      Get.snackbar("Error", "User not logged in or token missing",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  void _navigateToAddNewAddressScreen() async {
    String? userCode = await TokenHelper.getUserCode();
    String? token = await TokenHelper.getToken();
    if (userCode == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddNewAddressScreen(
              customerId: userCode,
              address: ListShippingAddressModel(),
            ),
      ),
    );
    if (result != null) {
      setState(() {
        selectedAddressIndex = 0;
        _initializeData();
      });
    }
  }

  Future<void> fetchShippingData() async {
    try {
      final data = await ShippingChargeService.fetchShippingCharge();
      if (data != null) {
        setState(() {
          shippingChargeData = data;
        });
      } else {
        // print("❌ No shipping charge data received");
        Get.snackbar("Error", "Failed to load shipping charges",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // print("❌ Error fetching shipping charge: $e");
      Get.snackbar("Error", "Error loading shipping charges",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  double calculateSubtotal() {
    if (widget.isSingleProduct) {
      return cartList1.fold(0.0, (sum, item) {
        double price = double.tryParse(item.sellingPrice?.toString() ?? '0') ?? 0.0;
        return sum + (price * (item.quantity ?? 1));
      });
    } else {
      return cartList.fold(0.0, (sum, item) {
        double price = double.tryParse(item.sellingPrice?.toString() ?? '0') ??
            0.0;
        return sum + (price * (item.quantity ?? 0));
      });
    }
  }

  double calculateShippingCharge(double totalAmount) {
    if (shippingChargeData == null) {
      // print("❌ Shipping charge data is null");
      return 0.0;
    }
    if (totalAmount >= (shippingChargeData?.maxAmount ?? 0)) {
      int multiples = (totalAmount / (shippingChargeData?.maxAmount ?? 1))
          .floor();
      return multiples * (shippingChargeData?.shippingCharge ?? 0);
    }
    return 0.0;
  }



  @override
  Widget build(BuildContext context) {
    if (!widget.isSingleProduct &&
        (widget.cartList == null || widget.cartList!.isEmpty)) {
      return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          title:   Text("Checkout"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: const Center(child: Text("Your cart is empty!")),
      );
    }

    double subtotal = calculateSubtotal();
    double shippingCharge = calculateShippingCharge(subtotal);
    double total = subtotal + shippingCharge;

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title:   Text("Checkout"),
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
                    // Order Summary
                    const Text("Order Summary",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    widget.isSingleProduct
                        ? _buildSingleProductSummary()
                        : _buildCartProductsSummary(),
                    const SizedBox(height: 24),
                    // Delivery Address
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Text("Delivery Address",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextButton(
                          onPressed: _navigateToAddNewAddressScreen,
                          child:   Text(
                            "+ Add New Address",
                            style: TextStyle(fontSize: 15,color: ColorConstants.appBlueColor3),
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
                            physics:   NeverScrollableScrollPhysics(),
                            itemBuilder: (_, i) => _buildShimmerEffect(),
                          );
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return   Center(child: Text("No address found!"));
                        } else if (snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text(" "));
                              // child: Text("📭 No addresses available."));
                        }
                        var addresses = snapshot.data!;
                        if (selectedAddressIndex < addresses.length &&
                            selectedAddressIndex >= 0) {
                          selectedAddress = addresses[selectedAddressIndex];
                        }
                        if (selectedAddressIndex >= addresses.length) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              selectedAddressIndex =
                              addresses.isNotEmpty ? 0 : -1;
                              selectedAddress =
                              addresses.isNotEmpty ? addresses[0] : null;
                            });
                          });
                        }
                        return ListView.builder(
                          itemCount: addresses.length,
                          shrinkWrap: true,
                          physics:   NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) =>
                              _buildAddressTile(addresses[index], index),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Payment Method
                      Text("Payment Method",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
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
                              child: Text(method, style: const TextStyle(
                                  color: Colors.black87)),
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
                      SizedBox(height: 16),
                    // Price Details
                      Text("Price Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        _priceRow("Item Price", subtotal),
                        _priceRow("Delivery Charges", shippingCharge),
                        const Divider(),
                        _priceRow("Total", total, isBold: true, isTotal: true),
                      ],
                    ),
                     SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () async {
                        final userCode = await TokenHelper.getUserCode();
                        final token = await TokenHelper.getToken();
                        if (token == null || token.isEmpty || userCode == null || userCode.isEmpty) {
                          Get.to(() => LoginScreen());
                          return;
                        }
                        if (orderController.isLoading.value) return;
                        if (selectedAddress == null) {
                          Get.snackbar("Error", "Please select a delivery address",
                              backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }
                        final getBuyNow = controllerGetBuy.getBuyNowDetails.value;

                        List<OrderProductList> productList = [];
                        if (widget.isSingleProduct && getBuyNow != null) {

                          double sellingPrice =
                              double.tryParse(getBuyNow.sellingPrice?.toString() ?? '0') ?? 0.0;
                          double mrp = double.tryParse(getBuyNow.mrp?.toString() ?? '0') ?? 0.0;
                          int quantity = getBuyNow.quantity ?? 1;
                          double discount = mrp - sellingPrice;
                          productList = [
                            OrderProductList(
                              productId: getBuyNow.productId ?? '',
                              ramId: getBuyNow.ramId ?? '',
                              romId: getBuyNow.romId ?? '',
                              colorId: getBuyNow.colorId ?? '',
                              orderOn: Platform.isAndroid?"android":"ios",
                              quantity: quantity,
                              discount: discount > 0 ? discount : 0.0,
                              totalMrp: mrp * quantity,
                              totalPrice: sellingPrice * quantity,
                              discountAmount: discount * quantity,
                              subTotalMrp: mrp * quantity,
                              subTotalDiscount: discount * quantity,
                              subTotalPrice: sellingPrice * quantity,
                            ),
                          ];
                        } else {
                          productList = cartList.map((cartItem) {
                            double sellingPrice = double.tryParse(cartItem.sellingPrice?.toString() ?? '0') ?? 0.0;
                            double mrp = double.tryParse(cartItem.mrp?.toString() ?? '0') ?? 0.0;
                            int quantity = cartItem.quantity ?? 1;

                            double discount = mrp - sellingPrice;
                            dynamic discountPer = sellingPrice * 100 / mrp;

                            return OrderProductList(
                              productId: cartItem.productId ?? '',
                              ramId: cartItem.ramId ?? '',
                              romId: cartItem.romId ?? '',
                              colorId: cartItem.colorId ?? '',
                              quantity: quantity,
                              discount: discountPer,
                              totalMrp: mrp * quantity,
                              totalPrice: sellingPrice * quantity,
                              discountAmount: discount * quantity,
                              subTotalMrp: mrp * quantity,
                              subTotalDiscount: discount * quantity,
                              subTotalPrice: sellingPrice * quantity,
                            );
                          }).toList();
                        }
                        if (productList.isEmpty) {
                          Get.snackbar("Error", "No products to order",backgroundColor: Colors.red, colorText: Colors.white);
                          return;
                        }
                        // print("Placing order with productList: ${productList.map((p) => p.toJson())}");
                        // print("Selected Address: ${selectedAddress?.toJson()}");

                        await orderController.placeOrder(
                          customerId: selectedAddress?.customerId ?? '',
                          shippingId: selectedAddress?.shippmentId ?? '',
                          name: selectedAddress?.name ?? '',
                          mobileNo: selectedAddress?.mobileNo ?? '',
                          emailId: selectedAddress?.emailId ?? '',
                          address: selectedAddress?.address ?? '',
                          landmark: "Near Park",
                          city: selectedAddress?.city?.toString() ?? '',
                          state: selectedAddress?.state?.toString() ?? '',
                          pincode: selectedAddress?.pinCode ?? '',
                          workType: selectedAddress?.workType ?? '',
                          totalMRP: (getBuyNow?.totalMrp ?? calculateSubtotal()).toDouble(),
                          totalPrice: subtotal,
                          totalAmount: total,
                          totalDiscount: (getBuyNow?.totalDiscount ?? 0).toDouble(),
                          deliveryCharge: (shippingChargeData?.shippingCharge ?? 0).toDouble(),
                          couponId: null,
                          couponAmount: 0.0,
                          productList: productList, selectedPaymentMethod: selectedPaymentMethod,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.appBlueColor3,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Obx(() {
                        return orderController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,)
                            : const Text("Place Order",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        );
                      }),
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
    return Obx(() {
      final productData = controllerGetBuy.getBuyNowDetails.value;

      if (controllerGetBuy.isLoading.value) {
        return   Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
      }
      if (productData == null) {
        return const Center(child: Text("No product data found."));
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "$imageAllBaseUrl${productData.productImage.toString()}",
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
                  productData.productName.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  "(${productData.ramName.toString()}/${productData.romName
                      .toString()}) | Color: ${productData.colorName
                      .toString()}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "₹${double.tryParse(productData.f2.toString())
                          ?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "₹${double.tryParse(productData.mrp.toString())
                          ?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
  Widget _buildCartProductsSummary() {
    return ListView.builder(
      shrinkWrap: true,
      physics:   NeverScrollableScrollPhysics(),
      itemCount: widget.cartList!.length,
      itemBuilder: (context, index) {
        final cartItem = widget.cartList![index];
        double price = double.tryParse(
            cartItem.sellingPrice?.toString() ?? '0') ?? 0.0;
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
                    Icon(Icons.image, size: 80,color: ColorConstants.appBlueColor3,),
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
          String? userCode = await TokenHelper.getUserCode();
          String? token = await TokenHelper.getToken();
          if (userCode == null || token == null) return false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddNewAddressScreen(customerId: userCode, address: address),
            ),
          );
          return false;
        } else {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text("Delete Address"),
                  content: const Text(
                      "Are you sure you want to delete this address?"),
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
                      customerId: widget.customerId,
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
            selectedAddressIndex = 0;
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
            });
          },
        ),
        title: Text("Name: ${address.name ?? ''} | ${address.workType ?? ''}"),
        subtitle: Text(
          "${address.address ?? ''}\n${address.city ?? ''} - ${address
              .pinCode ?? ''}\nPhone: ${address.mobileNo ?? ''}",
        ),
        isThreeLine: true,
      ),
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
          Text("₹${amount.toStringAsFixed(2)}", style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal,fontSize: isTotal ? 16 : 14,),
          ),
        ],
      ),
    );
  }
}