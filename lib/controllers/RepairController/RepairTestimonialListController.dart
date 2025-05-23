import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import 'package:fonofy/Api_Service/SellService/RepairTestimonialService.dart';
import 'package:fonofy/Api_Service/SellService/SellTestimonialListSerice.dart';
import 'package:fonofy/model/RepairModel/RepairTestimonialListModel.dart';
import 'package:fonofy/model/SellModel/SellTestimonialListModel.dart';
import 'package:get/get.dart';



// class RepairTestimonialController extends GetxController {
//   var isTestimonialListLoading = true.obs;
//   var testimonialListRepairData = <RepairTestimonialListModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getRepairTestimonialListData();
//   }
//
//   Future<void> getRepairTestimonialListData() async {
//     try {
//       isTestimonialListLoading(true);
//       final response = await RepairTestimonialService.fetchRepairTestimonialList();
//       if (response != null && response.isNotEmpty) {
//         testimonialListRepairData.assignAll(response);
//       } else {
//         testimonialListRepairData.clear();
//         Get.snackbar('Error', 'No testimonials received');
//       }
//     } catch (err) {
//       debugPrint('Testimonial List Error: $err');
//       Get.snackbar('Error', 'Failed to load testimonials: $err');
//       testimonialListRepairData.clear();
//     } finally {
//       isTestimonialListLoading(false);
//     }
//   }
//   void refreshTestimonials() {
//     testimonialListRepairData.clear();
//     isTestimonialListLoading.value = true;
//     getRepairTestimonialListData();
//   }
// }



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
      debugPrint('Testimonial List Error: $err');
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
