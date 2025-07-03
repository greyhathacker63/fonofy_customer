import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/ListShippingAddressService.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/DeleteShippingAddressService.dart';
import 'package:fonofy/Manage%20Address/AddNewAddressScreen.dart';
import 'package:shimmer/shimmer.dart';
import '../TokenHelper/TokenHelper.dart';
import '../model/ShippingAddressModel/ListShippingAddressModel.dart';

class ManageAddressScreen extends StatefulWidget {
  final String customerId;

  const ManageAddressScreen({super.key, required this.customerId});
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  Future<List<ListShippingAddressModel>>? _addressFuture;

  String token = "";

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Future<void> _initializeData() async {
  //   String? storedToken = await TokenHelper.getToken();
  //
  //   if (storedToken != null && storedToken.isNotEmpty) {
  //     token = storedToken;
  //     await _fetchAddressList();
  //   } else {
  //     print("⚠️ Token is missing. Please log in again.");
  //   }
  // }

  Future<void> _initializeData() async {
    String? storedToken = await TokenHelper.getToken();
    String? userCode = await TokenHelper.getUserCode();
    if (storedToken != null && storedToken.isNotEmpty && userCode != null) {
      token = storedToken;
      await _fetchAddressList();
    } else {
      print("⚠️ Token is missing. Please log in again.");
    }
  }

  Future<void> _fetchAddressList() async {
    setState(() {
      _addressFuture = ListShippingAddressService().listShippingAddress();
    });
  }

  void _navigateToAddNewAddressScreen() async {
    final result = await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewAddressScreen(
          customerId: widget.customerId,
          address: ListShippingAddressModel(),
        ),
      ),
    );
    if (result != null) {
      await _fetchAddressList();
    }
  }

  Future<void> deleteAddress(ListShippingAddressModel address) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Address"),
        content: const Text("Are you sure you want to delete this address?"),
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
            SnackBar(content: Text(result?.message ?? "Deleted successfully")),
          );
          setState(() {
            _fetchAddressList();
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Invalid ID or Shipment ID")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Addresses",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _navigateToAddNewAddressScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(color: Colors.black),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  "+ Add New",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _addressFuture == null
                  ? const Center(child: CircularProgressIndicator())
                  : FutureBuilder<List<ListShippingAddressModel>>(
                      future: _addressFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            itemCount: 5,
                            itemBuilder: (_, i) => _buildShimmerEffect(),
                          );
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const Center(
                              child: Text("❌ No address found!"));
                        } else if (snapshot.data!.isEmpty) {
                          // return const Center(child: Text("📭 No addresses available."));
                        }
                        var addresses = snapshot.data!;
                        return ListView.builder(
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final address = addresses[index];
                            return Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.black12),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${address.name} | ${address.workType}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      address.address ?? "",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      "${address.city ?? ""} - ${address.pinCode ?? ''}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      "📞 ${address.mobileNo ?? ""}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddNewAddressScreen(
                                                    customerId:
                                                        widget.customerId,
                                                    address: address,
                                                  ),
                                                ),
                                              );
                                              print(
                                                  "Address Data Debug ${address.city}");
                                              print(
                                                  "Address Data Debug ${address.state}");
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () async {
                                              await deleteAddress(address);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
}
