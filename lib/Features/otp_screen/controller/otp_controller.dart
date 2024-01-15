import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OtpController extends GetxController{
  late var _verificationId;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authenticateUser();
    startCountdown();


  }
  String otptxt="";
  final countdown = 0.obs;
  final TextEditingController textController = TextEditingController();

  void startCountdown() {
    int initialValue =60;
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


  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> authenticateUser() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+201015876911',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {
        print(error);
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        print(forceResendingToken);
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: "123456",
        );
        _verificationId=verificationId;
        print(credential.smsCode);

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
    );
  }

  Future<void> verifyOTP() async {


    try {

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otptxt,
      );

      await auth.signInWithCredential(credential);

      // The authentication is complete, you can navigate to the next screen or do something else.
    } catch (e) {
      print('Verification Failed: $e');
    }
  }


}