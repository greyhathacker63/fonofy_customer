
import 'package:get/get.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/ListShippingAddressService.dart';
 import 'package:fonofy/model/ShippingAddressModel/ListShippingAddressModel.dart';

class AddressRepairController extends GetxController {
  var isLoading = true.obs;
  var addressList = <ListShippingAddressModel>[].obs;
  var selectedAddressIndex = (-1).obs;
  String? customerId;
  String? token;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    customerId = await TokenHelper.getUserCode();
    token = await TokenHelper.getToken();
    if (customerId == null || token == null || customerId!.isEmpty || token!.isEmpty) {
      print('Error: customerId or token is missing');
      Get.snackbar('Error', 'User not logged in');
      isLoading(false);
      return;
    }
    print('Initializing with customerId: $customerId');
    await fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    if (customerId == null || token == null) return;
    try {
      isLoading(true);
      print('Fetching addresses for customerId: $customerId');
      final addresses = await ListShippingAddressService().listShippingAddress(
        customerId: customerId!,
        token: token!,
      );
      addressList.assignAll(addresses ?? []);
      print('Fetched ${addressList.length} addresses');
    } catch (e) {
      print('Error fetching addresses: $e');
      Get.snackbar('Error', 'Failed to load addresses');
    } finally {
      isLoading(false);
    }
  }
  void selectAddress(int index) {
    selectedAddressIndex.value = index;
    print('Selected address at index: $index');
    update();
  }

  // Future<void> deleteAddress(ListShippingAddressModel address) async {
  //   final confirm = await Get.defaultDialog<bool>(
  //     title: "Delete Address",
  //     content: const Text("Are you sure you want to delete this address?"),
  //     textCancel: "Cancel",
  //     textConfirm: "Delete",
  //     confirmTextColor: Colors.white,
  //     onConfirm: () => Get.back(result: true),
  //     onCancel: () => Get.back(result: false),
  //   );
  //
  //   if (confirm == true) {
  //     final id = address.id;
  //     final shipmentId = address.shippmentId;
  //     if (id != null && shipmentId != null && shipmentId.isNotEmpty) {
  //       print('Deleting address with id: $id, shipmentId: $shipmentId');
  //       final result = await DeleteAddressService.deleteAddress(
  //         id: id,
  //         shipmentId: shipmentId,
  //       );
  //       if (result != null && result.status == true) {
  //         Get.snackbar('Success', result.message ?? "Address deleted");
  //         await fetchAddresses();
  //       } else {
  //         Get.snackbar('Error', result?.message ?? "Failed to delete address");
  //       }
  //     } else {
  //       print('Invalid id or shipmentId: id=$id, shipmentId=$shipmentId');
  //       Get.snackbar('Error', 'Invalid ID or Shipment ID');
  //     }
  //   }
  // }
}