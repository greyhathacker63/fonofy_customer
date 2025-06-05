
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/SellTestimonialListSerice.dart';
import 'package:fonofy/models/SellTestimonialListModel/SellTestimonialListModel.dart';
import 'package:get/get.dart';

class TestimonialListController extends GetxController {
  var isTestimonialListLoading = true.obs;
  var testimonialList = <SellTestimonialListModel>[].obs; // Changed to RxList

  Future<void> getTestimonialListData() async {
    try {
      isTestimonialListLoading.value = true;
      final response = await SellTestimonialService.fetchTestimonialList();
      if (response != null && response.isNotEmpty) {
        testimonialList.assignAll(response);
      } else {
        testimonialList.clear();
        Future.microtask(() {
          Get.snackbar(
            'Error',
            'No testimonials available',
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    } catch (err) {
      testimonialList.clear();
      Future.microtask(() {
        Get.snackbar(
          'Error',
          'Failed to load testimonials: $err',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
        );
      });
    } finally {
      isTestimonialListLoading.value = false;
    }
  }

  Future<void> refreshTestimonials() async {
    await getTestimonialListData();
  }
}
