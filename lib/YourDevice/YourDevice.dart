import 'package:flutter/material.dart';
import 'package:fonofy/Device/DeviceDetailsScreen3.dart';
import 'package:fonofy/YourDevice/SelectPickupSlot.dart';
import 'package:fonofy/YourDevice/YourDeviceScreen2.dart';
import 'package:fonofy/controllers/DeviceQuestions/DeviceQuestionsController.dart';
import 'package:fonofy/controllers/SellControllers/SellCalculatorController.dart';
import 'package:fonofy/utils/Colors.dart';
import 'package:get/get.dart';

class YourDeviceScreen extends StatefulWidget {
  final String baseprice;
  final String? pid;
  final String bid;
  final String raid;
  final String roid;
  final String? selectedVariant;
  final String modelNo;
  final String ram;
  final String rom;
  final String modelName;
  final List finalhPageAns;

  const YourDeviceScreen({
    super.key,
    required this.baseprice,
    this.pid,
    required this.bid,
    required this.raid,
    required this.roid,
    this.selectedVariant,
    required this.modelNo,
    required this.ram,
    required this.rom,
    required this.modelName,
    required this.finalhPageAns,
  });

  @override
  State<YourDeviceScreen> createState() => _YourDeviceScreenState();
}

class _YourDeviceScreenState extends State<YourDeviceScreen> {
  final SellCalculatorController controller =
      Get.put(SellCalculatorController());
  final SellQuestionController questionController =
      Get.put(SellQuestionController());

  final RxDouble finalPrice = 0.0.obs;

  @override
  void initState() {
    super.initState();

    // Delay updates until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _recalculatePrice();
    });
  }

  Future<void> _recalculatePrice() async {
    final base = double.tryParse(widget.baseprice) ?? 0.0;

    await questionController.loadSellQuestions(
      bid: widget.bid,
      pid: widget.pid,
      raid: widget.raid,
      roid: widget.roid,
      model: widget.modelName,
      ram: widget.ram,
      rom: widget.rom,
      basePrice: base.toString(),
    );
    final List<String> weights = List<String>.from(widget.finalhPageAns);

    await controller.calculatePrice(
      questWeights: weights,
      basePrice: base,
    );

    finalPrice.value = controller.mSellPhoneListData?.finalPrice ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Your Device", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (finalPrice.value > 0) {
            print("Final Price (display): ${finalPrice.value}");
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Device info card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/iphone.png", height: 73),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.modelName.toString()} (${widget.ram}/${widget.rom})",
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text("Selling Price: ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54)),
                                Obx(() => Text(finalPrice.value.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))),
                                const Spacer(),
                                GestureDetector(
                                  onTap: _recalculatePrice,
                                  child: const Text(
                                    "Recalculate",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 11,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Features
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _FeatureIcon(icon: Icons.payment, label: "Fast Payments"),
                    _FeatureIcon(
                        icon: Icons.local_shipping, label: "Free Pickup"),
                    _FeatureIcon(icon: Icons.security, label: "100% Safe"),
                  ],
                ),
                const SizedBox(height: 12),

                // Coupons container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.local_offer, color: Colors.blue),
                      SizedBox(width: 10),
                      Text("Apply Coupons",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                const Text("Special Offers*",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text("Earn more with these offers and smile wider!",
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 12),

                // Offer cards (first row)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _OfferCard("assets/images/iphone.png", "iPhone Voucher",
                        finalPrice.value.toString()),
                    _OfferCard("assets/images/amazon.png",
                        "Amazon Pay Gift Card", finalPrice.value.toString()),
                  ],
                ),
                const SizedBox(height: 10),

                // Offer cards (second row)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _OfferCard("assets/images/flipkart.png",
                        "Flipkart Gift Card", finalPrice.value.toString()),
                    _OfferCard("assets/images/croma.png", "Croma",
                        finalPrice.value.toString()),
                  ],
                ),
                const SizedBox(height: 12),

                // WhatsApp switch
                Row(
                  children: [
                    const Expanded(
                        child: Text("Get price alerts & updates on Whatsapp",
                            style: TextStyle(fontSize: 14))),
                    Switch(
                      value: true,
                      activeColor: ColorConstants.appBlueColor3,
                      onChanged: (bool value) {},
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // FAQs section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("FAQs",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _FAQItem("How did you calculate my device price?"),
                          _FAQItem("Is it safe to sell my phone on Fonofy?"),
                          _FAQItem("How does Voucher Payment work?"),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text("Load More FAQs",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          )),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // Final price & button
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(finalPrice.value.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const Text("View Breakups",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blue)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => YourDeviceScreen2(
                                  finalPrice: finalPrice.value,
                                  baseprice: widget.baseprice,
                                  pid: widget.pid,
                                  bid: widget.bid,
                                  raid: widget.raid,
                                  roid: widget.roid,
                                  selectedVariant: widget.selectedVariant,
                                  modelNo: widget.modelNo,
                                  ram: widget.ram,
                                  rom: widget.rom,
                                  modelName: widget.modelName,
                                  finalhPageAns: widget.finalhPageAns,
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.appBlueColor3,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          child: const Text("Sell Now",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}

/// _FeatureIcon, _OfferCard, and _FAQItem remain unchanged...

class _FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureIcon({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 30),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String price;

  const _OfferCard(this.imagePath, this.label, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, height: 40),
          const SizedBox(height: 10),
          Text(label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          Text(price,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;

  const _FAQItem(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(question, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: Colors.black54),
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}
