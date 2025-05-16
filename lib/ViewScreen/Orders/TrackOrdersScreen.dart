import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/TrackingOrderServices.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/OrderModel/TrackingModel.dart';


class TrackOrdersScreen extends StatefulWidget {
  final String orderId;
  final String customerName;
  final String address;
  final String orderDate;
  final String status;
  

  const TrackOrdersScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.address,
    required this.orderDate,
    required this.status,
  });

  @override
  State<TrackOrdersScreen> createState() => _TrackOrdersScreenState();
}

class _TrackOrdersScreenState extends State<TrackOrdersScreen> {
  late Future<List<TrackingModel>> _trackingFuture;
  String currentStatus = '';
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTrackingData();
  }

  void _fetchTrackingData() async {
    try {
      final customerId = await TokenHelper.getUserCode();
      if (customerId == null) {
        throw Exception("Customer ID not found");
      }

      final data = await TrackingService.getTrackingData(widget.orderId, customerId);

      if (data.isNotEmpty) {
        setState(() {
          currentStatus = data.last.orderStatus.toString(); // use last status
          isLoading = false;
        });
      } else {
        setState(() {
          currentStatus = widget.status;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  int getStatusStep(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'confirmed':
        return 1;
      case 'dispatched':
        return 2;
      case 'delivered':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentStep = getStatusStep(currentStatus.isNotEmpty ? currentStatus : widget.status);

    List<Map<String, dynamic>> steps = [
      {'label': 'Pending', 'icon': Icons.watch_later},
      {'label': 'Confirm', 'icon': Icons.check_circle},
      {'label': 'Dispatch', 'icon': Icons.local_shipping},
      {'label': 'Deliver', 'icon': Icons.card_giftcard},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders Tracking"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text("Error: $errorMessage"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: ${widget.orderId}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Customer Name: ${widget.customerName}"),
                      Text("Shipping Address: ${widget.address}"),
                      Text("Order Date: ${widget.orderDate}"),
                      Text("Status: $currentStatus"),
                      const SizedBox(height: 30),

                      // Step Progress Tracker
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(steps.length, (index) {
                          bool isActive = index <= currentStep;
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: isActive ? Colors.blue : Colors.grey[300],
                                child: Icon(
                                  steps[index]['icon'],
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                steps[index]['label'],
                                style: TextStyle(
                                  color: isActive ? Colors.black : Colors.grey,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: List.generate(3, (index) {
                          return Expanded(
                            child: Container(
                              height: 4,
                              color: index < currentStep ? Colors.blue : Colors.grey[300],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
    );
  }
}
