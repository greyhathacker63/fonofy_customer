




import 'package:fonofy/Api_Service/SellService/RepairTestimonialService.dart';
import 'package:fonofy/models/RepairTestimonialListModel/RepairTestimonialListModel.dart';
import 'package:get/get.dart';

class RepairTestimonialController extends GetxController {
  var isTestimonialListRepairLoading  = true.obs;
  var testimonialRepairListData = <RepairTestimonialListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTestimonialRepairListData();
  }

  Future<void> getTestimonialRepairListData() async {

    try {
      isTestimonialListRepairLoading.value = true;
      final response = await  RepairTestimonialService.fetchRepairTestimonialList();
      if (response != null && response.isNotEmpty) {
        testimonialRepairListData.assignAll(response);
      } else {
        testimonialRepairListData.clear();
        Future.microtask(() {

        });
      }
    } catch (err) {
      testimonialRepairListData.clear();
      Future.microtask(() {
      });
    } finally {
      isTestimonialListRepairLoading.value = false;
    }}
    Future<void> refreshRepairTestimonials() async {
      await getTestimonialRepairListData();

  }
  }
