import 'package:flutter/material.dart';
import 'package:fonofy/controllers/OrderController/SellOrderDetailController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:fonofy/widgets/Order_Widgets/SellPriceAndScheduleWidget.dart';
import 'package:fonofy/widgets/RepairWidets/RepairPriceAndScheduleWidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class OrderSellDetailsScreen extends StatefulWidget {
  final String orderId;
  final String customerId;

  const OrderSellDetailsScreen({
    super.key,
    required this.orderId,
    required this.customerId,
  });

  @override
  State<OrderSellDetailsScreen> createState() => _OrderSellDetailsScreenState();
}

class _OrderSellDetailsScreenState extends State<OrderSellDetailsScreen> {
  final sellOrderDetailController = Get.put(SellOrderDetailController());

  @override
  void initState() {
    super.initState();
    sellOrderDetailController.fetchOrderDetails(
      widget.orderId,
      widget.customerId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Order Details', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: Obx(() {
        if (sellOrderDetailController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final item = sellOrderDetailController.productDetail.value;
        final orderInfo = sellOrderDetailController.orderInfo.value;

        if (item == null || orderInfo == null) {
          return const Center(child: Text('No order details found.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Sell Order :-',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorConstants.appBlueColor3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            ' ${item.orderId ?? ''}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildDashedLine(),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productAndModelName ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Color: ${item.colorName ?? ""}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: (item.image != null && item.image!.isNotEmpty)
                                    ? NetworkImage(item.image!)
                                    : const AssetImage('assets/images/phone.png') as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Total Price :- ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: ' ₹${item.totalAmount?.toStringAsFixed(2) ?? "0.00"}',
                              style: TextStyle(
                                color: ColorConstants.appBlueColor3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDashedLine(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SellPriceAndScheduleWidget(),
              // RepairPriceAndScheduleWidget(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = (constraints.maxWidth / 6).floor();
        return Wrap(
          spacing: 3,
          children: List.generate(
            count,
            (index) => Container(width: 3, height: 1, color: Colors.grey[400]),
          ),
        );
      },
    );
  }
}
