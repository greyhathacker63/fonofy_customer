import 'package:flutter/material.dart';
import 'package:fonofy/Api_Service/api_register.dart';
import 'package:fonofy/Api_Service/dashboard_services.dart';
import 'package:fonofy/model/RamModel.dart';
import 'package:fonofy/model/register_model.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var registerDataLoading = true.obs;
  var _registerData;

  RegisterModel? get getRegisterData => _registerData;
  Future<void> register(
      {String? firstName,
      String? phoneNumber,
      String? email,
      String? password}) async {
    return await RegisterService.registerApi(
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            firstName: firstName)
        .then((response) {
          registerDataLoading(true);
          _registerData = response;
        })
        .catchError((err) => debugPrint('Error in Register Data!!!!! : $err'))
        .whenComplete(() {
          registerDataLoading(false);
        });
  }
   var ramDataLoading = true.obs;
  var _ramListData;

  RamModel? get getRamData => _ramListData;

  Future<void> ramData(
      ) async {
    return await DashboardServices.ramListData(
        )
        .then((response) {
          ramDataLoading(true);
          _ramListData = response;
        })
        .catchError((err) => debugPrint('Error in Ram Data!!!!! : $err'))
        .whenComplete(() {
          ramDataLoading(false);
        });
  }
}
