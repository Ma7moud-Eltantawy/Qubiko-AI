import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Signup_controller extends GetxController{
  TextEditingController emailcon=TextEditingController();
  TextEditingController passcon=TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool check_active=false;
  bool check_seen=true;



  checkpassseen()
  {
    check_seen=!check_seen;
    update();
  }

  checkboxavtive()
  {
    check_active=!check_active;
    update();
  }
  
  Navigator()
  async {

    Get.to(Profile_screen(),transition: kTransition2,duration: kTransitionDuration);

  }



}