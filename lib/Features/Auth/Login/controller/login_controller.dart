import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/Home_Screen/home/presentation/view/home_layout_detect.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:quickai/core/utils/functions.dart';
import 'package:quickai/data/Auth_Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quickai/data/DB_Helper.dart';

import '../../../Home_Screen/home/presentation/view/Home_Screen_view.dart';

class Login_controller extends GetxController{
  bool check_seen=true;
  final BaseAuthDataSource _remmoteDataSource = AuthRemoteDataSource();
  final BaseDBhelperdatasource _dBhelperdatasource=RemoteDBhelperdatasource();
  TextEditingController emailcon=TextEditingController();
  TextEditingController passcon=TextEditingController();
  final loginformKey = GlobalKey<FormState>();
  bool check_active=false;
  bool loadingstate=false;
  bool progresshudstate=false;


  checkboxavtive()
  {
    check_active=!check_active;
    update();
  }
  void changeLoadingValue() {
    loadingstate=!loadingstate;
    update();
  }
  void changeprogresshudValue() {
    progresshudstate=!progresshudstate;
    update();
  }


  Navigator()
  {
    Get.offAllNamed(HomepageLayout.scid);
  }

  Future login({required BuildContext ctx, required double height, required double width}) async {
    try {
      // Assuming _remmoteDataSource is an instance of your data source class
      final loginResult = await _remmoteDataSource.login(
        email: emailcon.text.trim(),
        pass: passcon.text,
      );
      if (loginResult.data == null) {
        // Handle the case where login data is null
        return;
      }

      changeLoadingValue();
      /// Check if the email is verified
      final verificationResult = await _remmoteDataSource.checkEmailVerified();

      print(verificationResult.data);

      if (verificationResult.data == verifiedenum.Verify) {

        await Future.delayed(Duration(seconds: 5));
        changeLoadingValue();
        print(loginResult.data);
        changeprogresshudValue();
        if (loginResult.requestState == RequestState.success) {
          if (loginResult.data!.user != null) {
            // Retrieve user data from your data source
            final userdata = await _remmoteDataSource.Getuserdata(id: loginResult.data!.user!.uid);
            await _dBhelperdatasource.SaveuserinDB(user: userdata.data!);
            final value = await _dBhelperdatasource.getuserfromDB();
            print(value.requestState);
            if (value.requestState == RequestState.success) {
              changeprogresshudValue();
              Navigator();
            }
          }
        } else if (loginResult.requestState == RequestState.failed) {
          await _remmoteDataSource.logout();
          changeLoadingValue();
        }
      } else {

        await _remmoteDataSource.logout();
        await _dBhelperdatasource.removeuserdata();
        changeLoadingValue();
        return;
      }
    } catch (e) {
      // Handle exceptions here
      print("Error during login: $e");
    }
  }

  checkpassseen()
  {
    check_seen=!check_seen;
    update();
  }

}

