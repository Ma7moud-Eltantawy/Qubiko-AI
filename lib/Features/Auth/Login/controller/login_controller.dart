import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/Home_Screen/home/view/Home_Screen_view.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:quickai/core/utils/functions.dart';
import 'package:quickai/data/Auth_Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quickai/data/DB_Helper.dart';

class Login_controller extends GetxController{
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
    Get.offAll(()=>Home_screen(),transition: kTransition2,duration: kTransitionDuration);
  }

  Future login({required BuildContext ctx,required double heidht, required double width}) async {
    changeLoadingValue();
    RequestResult<UserCredential> ? result;

    _remmoteDataSource.checkEmailVerified().then((checkresult) async {
      print(checkresult.data);
      if (checkresult.data == verifiedenum.Verify) {
        result = await _remmoteDataSource.login(
          email: emailcon.text.trim(),
          pass: passcon.text,
        );


        Future.delayed(Duration(seconds: 5));
        changeLoadingValue();
        print(result!.data);
        if (result!.data == null) {
          return;
        };
        changeprogresshudValue();
        if (result!.requestState == RequestState.success) {
          if (result!.data!.user != null) {
            await _remmoteDataSource.Getuserdata(id: result!.data!.user!.uid)
                .then((userdata) async {
              await _dBhelperdatasource.SaveuserinDB(user: userdata.data!);
              await _dBhelperdatasource.getuserfromDB().then((value) async {
                print(value.requestState);
                if (value.requestState == RequestState.success) {
                  changeprogresshudValue();
                  Navigator();
                }
              });
            });
          }
        } else if (result!.requestState == RequestState.failed) {
          // Fail_toast(ctx: ctx, title: "login failed", height: heidht, width: width, desc: "email or password is incorrect");

        }
      }
      else {
        changeLoadingValue();
        return;
      }
    });
  }


}

