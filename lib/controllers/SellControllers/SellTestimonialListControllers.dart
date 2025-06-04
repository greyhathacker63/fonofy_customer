// import 'package:flutter/cupertino.dart';
// import 'package:fonofy/Api_Service/SellService/SellTestimonialListSerice.dart';
// import 'package:fonofy/model/SellModel/SellTestimonialListModel.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// class TestimonialListController extends GetxController {
//   var isTestimonialListLoading = true.obs;
//   List<SellTestimonialListModel> _testimonialList = [];
//
//   List<SellTestimonialListModel> get testimonialListData => _testimonialList;
//
//   Future<void> getTestimonialListData() async {
//     isTestimonialListLoading.value = true;
//     try {
//       _testimonialList = await SellTestimonialService.fetchTestimonialList();
//     } catch (err) {
//       debug// print('Brand List Error: $err');
//     } finally {
//       isTestimonialListLoading.value = false;
//       update(); // Notify UI
//     }
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/SellService/SellTestimonialListSerice.dart';
import 'package:fonofy/models/SellTestimonialListModel/SellTestimonialListModel.dart';
import 'package:get/get.dart';



// class TestimonialListController extends GetxController {
//   var isTestimonialListLoading = true.obs;
//   var testimonialListData = <SellTestimonialListModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getTestimonialListData();
//   }
//
//   Future<void> getTestimonialListData() async {
//     try {
//       isTestimonialListLoading(true);
//       final response = await SellTestimonialService.fetchTestimonialList();
//       if (response != null && response.isNotEmpty) {
//         testimonialListData.assignAll(response);
//       } else {
//         testimonialListData.clear();
//         Get.snackbar('Error', 'No testimonials received');
//       }
//     } catch (err) {
//       debug// print('Testimonial List Error: $err');
//       Get.snackbar('Error', 'Failed to load testimonials: $err');
//       testimonialListData.clear();
//     } finally {
//       isTestimonialListLoading(false);
//     }
//   }
//   void refreshTestimonials() {
//     testimonialListData.clear();
//     isTestimonialListLoading.value = true;
//     getTestimonialListData();
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

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
      debug// print('Testimonial List Error: $err');
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