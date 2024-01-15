import 'dart:io';

import 'package:quickai/Features/Auth/Sign_up/controller/singnup_controller.dart';
import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:quickai/data/Auth_Helper.dart';

import '../../../../core/utils/functions.dart';
import '../../../../data/DB_Helper.dart';

class Profile_controller extends GetxController{
  bool loadingstate=false;
  bool progresshudstate=false;
  TextEditingController datecon=TextEditingController();
  TextEditingController namecon=TextEditingController();
  TextEditingController phonecon=TextEditingController();

  BaseAuthDataSource _baseAuthDataSource=AuthRemoteDataSource();
  BaseDBhelperdatasource _dBhelperdatasource=RemoteDBhelperdatasource();
  Signup_controller signupcontroller=Get.put(Signup_controller());



  final formKey = GlobalKey<FormState>();
   RequestResult<String> ? imgpath;
  XFile? imgfile;
  bool check_active=false;

  checkboxavtive()
  {
    check_active=!check_active;
    update();
  }

  Navigator() async
  {
    changeLoadingValue();
    await _baseAuthDataSource.SignUp(email: signupcontroller.emailcon.text, pass: signupcontroller.passcon.text, ctx: Get.context!).then((userdata) async {
      changeLoadingValue();

      if(userdata.requestState==RequestState.success){
        changeprogresshudValue();

        if(imgfile!=null)
          {
            imgpath= await _baseAuthDataSource.Uploadimgtostorage(img: imgfile!);
            update();
          }

        await _baseAuthDataSource.uploaduserdata(user: Userdatamodel(
            userid: userdata.data!.user!.uid,
            name: namecon.text,
            phone: phonecon.text,
            pic: imgpath!=null?imgpath!.data.toString(): "https://firebasestorage.googleapis.com/v0/b/chatbot-b23a0.appspot.com/o/def_img.png?alt=media&token=ee8eb44c-fd87-4a12-b9c8-d8f13b19c36f",
            verified: true,
            Premiun: false,
            premuimtodate: "",
            Premuimplan: PaymentPLAN.free.toString(),
            DateofBirth: datecon.text));
        await _baseAuthDataSource.Verifyaccount(ctx: Get.context!);
        changeprogresshudValue();
        Get.offAll(()=>Welcome_Screen(),transition: kTransition2,duration: kTransitionDuration);
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("The account has been created. Go to your email to activate this account.",style: getRegularStyle(color: ColorsManager.burble, fontSize: width/50),)));

      }



    });

    //Get.to(Profile_screen(),transition: kTransition2,duration: kTransitionDuration);

  }
  Pickimagefromsource(ImageSource source,String croptitle) async
  {
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return;

       ///crop
      final croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: croptitle,
          toolbarColor: ColorsManager.burble,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          activeControlsWidgetColor: ColorsManager.burble
        ),
        iosUiSettings: IOSUiSettings(
          title: croptitle,
          aspectRatioLockEnabled: false,
        ),
      );

      if (croppedImage == null) return;
      imgfile = XFile(croppedImage.path);
      //final croppedFile = File(croppedImage.path);

      print(imgfile!.path);
    }
    catch(e)
    {}

    update();

  }
  datapicker(BuildContext context)
  {

    showdatePicker(context: context,textcon:datecon );

  }
  void changeLoadingValue() {
    loadingstate=!loadingstate;
    update();
  }
  void changeprogresshudValue() {
    progresshudstate=!progresshudstate;
    update();
  }




}