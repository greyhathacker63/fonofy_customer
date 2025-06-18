import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../controllers/RepairController/RepairOrderListController.dart';
import '../utils/Colors.dart';
import 'OrderRepairDetailsScreen.dart';

class RepairOrderListScreen extends StatefulWidget {
  final String customerId;

  const RepairOrderListScreen({super.key, required this.customerId});

  @override
  State<RepairOrderListScreen> createState() => _RepairOrderListScreenState();
}

class _RepairOrderListScreenState extends State<RepairOrderListScreen> {
  final RepairOrderListController repairOrderListController = Get.put(RepairOrderListController());

  @override
  void initState() {
    super.initState();
    repairOrderListController.getRepairOrdersList(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:   Text('Repair Orders List'),
      ),
      body: Column(
        children: [
            SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              if (repairOrderListController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
                );
              }
              if (repairOrderListController.repairOrdersList.isEmpty) {
                return const Center(child: Text(' '));
              }

              return ListView.builder(
                itemCount: repairOrderListController.repairOrdersList.length,
                itemBuilder: (context, index) {
                  final orderDetails = repairOrderListController.repairOrdersList[index];
                  return Card(
                    color: Colors.white,
                    margin:   EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '$imageAllBaseUrl${orderDetails.image ?? ''}',
                          width: 60,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>   Icon(Icons.image,color: ColorConstants.appBlueColor3,),
                        ),
                      ),
                      title: Text("Order ID:-${orderDetails.orderId}", style:   TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                      subtitle: Text("Repair Date :- ${orderDetails.createdDate}" "",style: TextStyle(fontSize: 11),),
                      trailing:   Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => OrderRepairDetailsScreen()));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
