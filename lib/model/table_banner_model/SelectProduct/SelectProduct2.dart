import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Device/DeviceDetailsScreen.dart';
import 'package:fonofy/Device/DeviceDetailsScreen5.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';
import '../../../controllers/SellControllers/SellVariantPriceControllers.dart';
import '../../../widgets/SellWidgets/buildFaqItem.dart';
import '../../../widgets/SellWidgets/buildOfferRow.dart';

class SelectProduct2 extends StatefulWidget {
  final String selectedVariant;
  final String modelNo;
  final String ram;
  final String rom;

  const SelectProduct2({
    super.key,
    required this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
  });

  @override
  _SelectProduct2State createState() => _SelectProduct2State();
}

class _SelectProduct2State extends State<SelectProduct2> {
  final SellVariantControllerPrice sellVariantPriceController =
      Get.put(SellVariantControllerPrice());

  @override
  void initState() {
    super.initState();
    sellVariantPriceController.getPriceVariantData(
        widget.modelNo, widget.ram, widget.rom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text("Select Product", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => sellVariantPriceController.isVariantPriceLoading.value
            ? Center(
                child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
              ))
            : sellVariantPriceController.priceVariantData == null
                ? Center(
                    child: Text(
                        "No price data available. Please try again or contact support."))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              _buildProductImage(sellVariantPriceController),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${sellVariantPriceController.priceVariantData?.modelName.toString()}\n"
                                      "(${sellVariantPriceController.priceVariantData?.ramName.toString()} / "
                                      "${sellVariantPriceController.priceVariantData?.romName.toString()})",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ColorConstants.appBlueColor3,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text("Get Up to",
                                        style:
                                            TextStyle(color: Colors.black54)),
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          "₹ ${sellVariantPriceController.priceVariantData?.basePrice.toStringAsFixed(0) ?? 0}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),

                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "The price stated above depends on the condition of the product and is not final. "
                            "The final price offer will be quoted at the end of the diagnosis.",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                        SizedBox(height: 15),
                        // New Phone Offer
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/Iphone2.png",
                                  height: 50, width: 50),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Purchasing New iPhone?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Get upto ₹4000* Bonus & avail it at various stores",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Special Offers
                        const Text("Special Offer",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            children: [
                              buildOfferRow("assets/images/instantBank.png",
                                  "Instant bank transfer"),
                              buildOfferRow("assets/images/GiftCard.png",
                                  "Get 3.5% Extra Amazon Pay Gift Card"),
                              buildOfferRow(
                                  "assets/images/FlipkartGiftCard.png",
                                  "Get 3.5% Extra Flipkart Gift Card"),
                              buildOfferRow("assets/images/VoucherCroma.png",
                                  "Get 1% Extra with this voucher Croma"),
                              buildOfferRow("assets/images/UPI.png", "UPI"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // FAQs
                        const Text("FAQs",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        buildFaqItem("How did you calculate my device price?"),
                        buildFaqItem("Is it safe to sell my phone on Fonofy?"),
                        buildFaqItem("How does Voucher Payment work?"),
                        const SizedBox(height: 10),
                        // Load More FAQs
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Load More FAQs",
                                style: TextStyle(color: Colors.lightBlueAccent)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Get Exact Value Button
                      ],
                    ),
                  ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Get.to(() => DeviceDetailsScreen(
              //       baseprice: sellVariantPriceController
              //           .priceVariantData!.basePrice.toString(),
              //       bid: sellVariantPriceController.priceVariantData!.brandId
              //           .toString(),
              //       modelNo: sellVariantPriceController
              //           .priceVariantData!.modelId
              //           .toString(),
              //       ram: sellVariantPriceController.priceVariantData!.ramName
              //           .toString(), // ✅ corrected
              //       rom: sellVariantPriceController.priceVariantData!.romName
              //           .toString(),
              //       raid: sellVariantPriceController.priceVariantData!.ramId
              //           .toString(),
              //       roid: sellVariantPriceController.priceVariantData!.romId
              //           .toString(), modelName:sellVariantPriceController.priceVariantData!.modelName
              //           .toString() ,

              //     ));

              Get.to(() => DeviceDetailsScreen5(
                    baseprice: sellVariantPriceController
                        .priceVariantData!.basePrice
                        .toString(),
                    bid: sellVariantPriceController.priceVariantData!.brandId
                        .toString(),
                    modelNo: sellVariantPriceController
                        .priceVariantData!.modelId
                        .toString(),
                    ram: sellVariantPriceController.priceVariantData!.ramName
                        .toString(), // ✅ corrected
                    rom: sellVariantPriceController.priceVariantData!.romName
                        .toString(),
                    raid: sellVariantPriceController.priceVariantData!.ramId
                        .toString(),
                    roid: sellVariantPriceController.priceVariantData!.romId
                        .toString(),
                    modelName: sellVariantPriceController
                        .priceVariantData!.modelName
                        .toString(),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.appBlueColor3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
            ),
            child: Text(
              "Get Exact Value",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(SellVariantControllerPrice controller) {
    final imagePath = controller.priceVariantData?.image ?? '';
    final imageUrl = imagePath != null && imagePath.isNotEmpty
        ? imagePath.startsWith('/')
            ? '$imageAllBaseUrl$imagePath'
            : '$imageAllBaseUrl/$imagePath'
        : null;
    debugPrint('SelectProduct2 Image URL: $imageUrl');

    return imageUrl != null
        ? Image.network(
            imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                height: 80,
                width: 80,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorConstants.appBlueColor3,
                )),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              debugPrint('SelectProduct2 Image Error: $error, URL: $imageUrl');
              return Image.asset(
                "assets/images/Phone3.png",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              );
            },
          )
        : Image.asset(
            "assets/images/Phone3.png",
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          );
  }
}
