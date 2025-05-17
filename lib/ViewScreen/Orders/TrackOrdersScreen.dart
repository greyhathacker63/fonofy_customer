import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/TrackingOrderServices.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/model/OrderModel/TrackingModel.dart';
import 'package:fonofy/utils/Colors.dart';

class TrackOrdersScreen extends StatefulWidget {
  final String orderId;
  final String customerName;
  final String address;
  final String orderDate;
  final String status;
  final String confirmDate;
  final String dispatchDate;

  const TrackOrdersScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.address,
    required this.orderDate,
    required this.status, required this.confirmDate, required this.dispatchDate,
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

      final data =
          await TrackingService.getTrackingData(widget.orderId, customerId);

      if (data.isNotEmpty) {
        // Sort by createdDate ascending (oldest first, latest last)
        data.sort((a, b) {
          DateTime? dateA = a.createdDate;
          DateTime? dateB = b.createdDate;

          if (dateA == null && dateB == null) return 0;
          if (dateA == null) return 1;
          if (dateB == null) return -1;

          return dateA.compareTo(dateB);
        });

        setState(() {
          currentStatus = data.last.orderStatus.toString();
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
    int currentStep = getStatusStep(
      currentStatus.isNotEmpty ? currentStatus : widget.status,
    );

    List<Map<String, dynamic>> steps = [
      {
        'label': 'Order Placed',
        'datetime': widget.orderDate,
        'location': '',
        'icon': Icons.shopping_cart,
      },
      {
        'label': 'Order Confirmed',
        'datetime': widget.confirmDate, // Could be filled from tracking data
        'location': '',
        'icon': Icons.verified,
      },
      {
        'label': 'Order Dispatched',
        'datetime': widget.dispatchDate, // Could be filled from tracking data
        'location': '',
        'icon': Icons.local_shipping,
      },
      {
        'label': 'Delivered Successfully',
        'datetime': '',
        'location': currentStatus.toLowerCase() == 'delivered'
            ? 'Delivered to ${widget.address}'
            : 'Not delivered yet',
        'icon': Icons.thumb_up_alt_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Tracking"),
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
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Customer Name: ${widget.customerName}"),
                      Text("Shipping Address: ${widget.address}"),
                      Text("Order Date: ${widget.orderDate}"),
                      Text("Status: $currentStatus"),
                      const SizedBox(height: 30),

                      /// Vertical Timeline
                      Column(
                        children: List.generate(steps.length, (index) {
                          bool isActive = index <= currentStep;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Timeline indicator
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: isActive
                                        ? ColorConstants.appBlueColor3
                                        : Colors.grey[300],
                                    child: Icon(
                                      steps[index]['icon'],
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  if (index != steps.length - 1)
                                    Container(
                                      width: 2,
                                      height: 40,
                                      color: Colors.grey,
                                    ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              // Step Content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      steps[index]['label'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isActive
                                            ? ColorConstants.appBlueColor3
                                            : Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (steps[index]['datetime'].toString().isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          steps[index]['datetime'],
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                      ),
                                    if (steps[index]['location'].toString().isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          steps[index]['location'],
                                          style: TextStyle(
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
    );
  }
}
