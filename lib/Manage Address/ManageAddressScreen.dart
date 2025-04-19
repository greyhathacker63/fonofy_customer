import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/ListShippingAddressService.dart';
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

  late final Future<List<ListShippingAddressModel>> _addressFuture;

  String token = "";

  @override
  void initState() {
    super.initState();
    _initializeData();
  }
  Future<void> _initializeData() async {

    String? storedToken = await TokenHelper.getToken();

    if (storedToken != null && storedToken.isNotEmpty) {
      setState(() {
        token = storedToken;
        print(token);
        _fetchAddressList();
      });
    } else {
      print("⚠️ Token is missing. Please log in again.");
    }
  }
  void _fetchAddressList() {
    setState(() {
      _addressFuture = ListShippingAddressService().listShippingAddress(
        customerId: widget.customerId,
        token: token,
      );
    });
  }
  void _navigateToAddNewAddressScreen() async {

    final result = await Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => AddNewAddressScreen(customerId: widget.customerId, address: ListShippingAddressModel()),
      ),
    );
    if (result != null) {
      _fetchAddressList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Addresses",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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

                child: Text("+ Add New",style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<ListShippingAddressModel>>(
                future: _addressFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (_, i) {
                        return _buildShimmerEffect();
                      },
                    );
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return const Center(
                      child: Text("❌ No address found!"),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("📭 No addresses available."),
                    );
                  }
                  var addresses = snapshot.data!;
                  return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2, color: Colors.black12),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${address.name} | ${address.workType}",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                address.address ?? "NA",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                "${address.city ?? "NA"} - ${address.pinCode ?? 'NA'}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Text(
                                "📞 ${address.mobileNo ?? "NA"}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => AddNewAddressScreen(
                                          customerId: widget.customerId,
                                          address: address,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        print("Delete Address: ${address.city}");
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
}
