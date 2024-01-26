
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quickai/Features/Home_Screen/home/presentation/view/home_layout_detect.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:get/get.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import 'package:quickai/data/Auth_Helper.dart';
import 'package:quickai/data/DB_Helper.dart';

import '../../../core/enums.dart';
import '../../../core/utils/functions.dart';
import '../../../data/Google_Ads.dart';



class Splash_controller extends GetxController{

  BaseDBhelperdatasource _baseDBhelperdatasource=RemoteDBhelperdatasource();
  final BaseAuthDataSource baseAuthDataSource = AuthRemoteDataSource();



  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: [
          Platform.isAndroid ? AdIdhelper.androidAppId : AdIdhelper.iosAppId
        ]));

    Future.delayed(Duration(seconds: 7)).then((value) async {
     await Navigator();

    });





  }


  Navigator()
  async {


    _baseDBhelperdatasource.OnBoardingseencheck().then((onboardstate) {
      if(onboardstate.data==Onboardseenenum.Seen)
        {


            _baseDBhelperdatasource.getuserfromDB().then((dbuser) async {
              if(currentuserdata!=null) {

                bool checkIsprem = currentuserdata!.Premiun!;
                print("is prem: $checkIsprem");
                if (checkIsprem) {
                  bool checkpremdate = Checkpremuimdate(
                      date: DateTime.parse(currentuserdata!.premuimtodate!));
                  if (!checkpremdate) {
                    await baseAuthDataSource.uploaduserdata(
                        user: Userdatamodel(
                            email: currentuserdata!.email!,
                            userid: currentuserdata!.userid!,
                            name: currentuserdata!.name!,
                            phone: currentuserdata!.phone!,
                            pic: currentuserdata!.pic!,
                            verified: currentuserdata!.verified!,
                            Premiun: false,
                            premuimtodate: "",
                            Premuimplan: PaymentPLAN.free.toString(),
                            DateofBirth: currentuserdata!.DateofBirth!
                        )).then((value) async {
                      if (value.requestState == RequestState.success) {
                        await baseAuthDataSource.Getuserdata(id: currentuserdata!
                            .userid!).then((userdata) async {
                          if (value.requestState == RequestState.success) {
                            await _baseDBhelperdatasource.SaveuserinDB(
                                user: userdata.data!);
                            await _baseDBhelperdatasource.getuserfromDB();
                          }
                        });
                      }
                    });
                  }
                }
                if (dbuser.requestState == RequestState.success) {
                 Get.offAllNamed(HomepageLayout.scid);

                }
                else {
                  print("db null");
                  Get.off(() => Welcome_Screen(), transition: kTransition2,
                      duration: Duration(seconds: 1));
                }

              }
              else {
                print("currentuserdata null");
                Get.off(() => Welcome_Screen(), transition: kTransition2,
                    duration: Duration(seconds: 1));
              }






            });}

      else{
        Get.off(()=>onBoarding_Screen(),transition: kTransition2,duration:Duration(seconds: 1));

      }
    });


  }

}