import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/Home_Screen/home/presentation/view/home_layout_detect.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/data/Auth_Helper.dart';
import 'package:quickai/data/chatgpt.dart';

import '../../../../data/DB_Helper.dart';
class OtpController extends GetxController {
  BaseAuthDataSource _authDataSource = AuthRemoteDataSource();
  final BaseDBhelperdatasource _dBhelperdatasource=RemoteDBhelperdatasource();

  String ?_verificationId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authenticateUser();
    startCountdown();
  }

  String otptxt = "";
  final countdown = 0.obs;
  final TextEditingController textController = TextEditingController();

  void startCountdown() {
    int initialValue = 60;
    if (initialValue > 0) {
      countdown.value = initialValue;
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (countdown.value > 0) {
          countdown.value--;
          update();
          print(countdown);
        } else {
          timer.cancel(); // Stop the timer when countdown reaches zero
        }
      });
    }
  }


  Future<void> authenticateUser() async {
    _authDataSource.sendOTP(number: currentuserdata!.phone!).then((value) {
      if (value.requestState == RequestState.success) {
        _verificationId = value.data;
      }
    });
  }

  Future<void> verifyOTP() async {
    _authDataSource.activeByphone(verifyid: _verificationId!, smscode: otptxt).then((value) async {
      if(value.requestState==RequestState.success)
        {

          Get.offAllNamed(HomepageLayout.scid);

        }
        else{
        await _authDataSource.logout();
        await _dBhelperdatasource.removeuserdata();
        Get.back();
      }

    });
  }

}