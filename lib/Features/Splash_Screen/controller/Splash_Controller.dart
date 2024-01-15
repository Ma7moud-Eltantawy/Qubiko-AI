
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickai/Features/Home_Screen/home/view/Home_Screen_view.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:get/get.dart';
import 'package:quickai/data/DB_Helper.dart';

import '../../../core/enums.dart';
class Splash_controller extends GetxController{
  BaseDBhelperdatasource _baseDBhelperdatasource=RemoteDBhelperdatasource();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(seconds: 5)).then((value){
      Navigator();
    });
  }

  Navigator()
  {
    _baseDBhelperdatasource.OnBoardingseencheck().then((onboardstate) {
      if(onboardstate.data==Onboardseenenum.Seen)
        {
          _baseDBhelperdatasource.getuserfromDB().then((dbuser){
            if(dbuser.requestState==RequestState.success)
              {
                Get.off(()=>Home_screen(),transition: kTransition2,duration:Duration(seconds: 1));

              }
            else
              {
                Get.off(()=>Welcome_Screen(),transition: kTransition2,duration:Duration(seconds: 1));

              }

          });

        }
      else{
        Get.off(()=>onBoarding_Screen(),transition: kTransition2,duration:Duration(seconds: 1));

      }
    });


  }

}