import 'dart:io';

import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickai/data/Auth_Helper.dart';
import 'package:quickai/data/DB_Helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/enums.dart';
import '../../../core/models/Userdatamodel.dart';
import '../../../core/networking/request_result.dart';
import '../../../core/utils/functions.dart';
import '../../Home_Screen/home/controller/Home_screen_controller.dart';

class profileinfocontrroler extends GetxController {
  home_Sreen_controller homecont=Get.put(home_Sreen_controller());


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    namecon = TextEditingController();
    phonecon = TextEditingController();
    datecon = TextEditingController();
  }

  final BaseAuthDataSource _baseAuthDataSource = AuthRemoteDataSource();
  final BaseDBhelperdatasource _baseDBhelperdatasource=RemoteDBhelperdatasource();


  late TextEditingController namecon;
  late TextEditingController phonecon;
  late TextEditingController datecon;


  RequestResult<String> ? imgpath;
  bool editstate = false;
  final formKey = GlobalKey<FormState>();
  XFile? imgfile;
  bool check_active = false;


  changeeditstate() async {
    if (editstate == true) {
      await updateuserdata();
    }
    editstate = !editstate;
    update();
  }

  checkboxavtive() {
    check_active = !check_active;
    update();
  }

  Navigator() {
    Get.to(Profile_screen(), transition: kTransition2,
        duration: kTransitionDuration);
  }

  Pickimagefromsource(ImageSource source, String croptitle) async
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
    catch (e) {}

    update();
  }

  datapicker(BuildContext context) {
    showdatePicker(context: context, textcon: datecon);
  }


  Future<void> updateuserdata() async {
    if (imgfile != null || namecon.text.isNotEmpty ||
        phonecon.text.isNotEmpty||datecon.text.isNotEmpty)


      {
      if (imgfile != null) {
        imgpath = await _baseAuthDataSource.Uploadimgtostorage(img: imgfile!);
        update();
      }

    await _baseAuthDataSource.uploaduserdata(user: Userdatamodel(
        userid: currentuserdata!.userid!,
        name: namecon.text.isNotEmpty ? namecon.text : currentuserdata!.name!,
        phone: phonecon.text.isNotEmpty ? phonecon.text : currentuserdata!
            .phone!,
        pic: imgpath != null ? imgpath!.data.toString() : currentuserdata!.pic!,
        verified: currentuserdata!.verified,
        Premiun: currentuserdata!.Premiun,
        premuimtodate: currentuserdata!.premuimtodate,
        Premuimplan: currentuserdata!.Premuimplan,
        email: currentuserdata!.email!,
        DateofBirth: datecon.text.isNotEmpty ? datecon.text : currentuserdata!
            .DateofBirth!)).then((value)async{

      if(value.requestState==RequestState.success)
      {
        await _baseAuthDataSource.Getuserdata(id: currentuserdata!.userid!).then((userdata) async {
          if(value.requestState==RequestState.success)
          {
            await _baseDBhelperdatasource.SaveuserinDB(user: userdata.data!);
            await _baseDBhelperdatasource.getuserfromDB();
            print("update");

          }

        });
      }
    });
    //Get.offAll(()=>Welcome_Screen(),transition: kTransition2,duration: kTransitionDuration);
    showsnackbar(content: "user data updated");
  }
    else{
      showsnackbar(content: "Not data Changed");
    }
    homecont.onReady();
    //homecont.updatedatabase();
    update();


  }



}






