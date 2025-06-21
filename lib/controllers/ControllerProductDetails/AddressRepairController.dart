
import 'package:get/get.dart';
import 'package:fonofy/TokenHelper/TokenHelper.dart';
import 'package:fonofy/Api_Service/ShippingAddressService/ListShippingAddressService.dart';
 import 'package:fonofy/model/ShippingAddressModel/ListShippingAddressModel.dart';

class AddressRepairController extends GetxController {
  var isLoading = true.obs;
  var addressList = <ListShippingAddressModel>[].obs;

   var addressRepair = Rxn<ListShippingAddressModel>();
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
 }