import 'dart:io';

import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/utils/functions.dart';

class profileinfocontrroler extends GetxController{
  TextEditingController namecon=TextEditingController();
  TextEditingController phonecon=TextEditingController();
  TextEditingController datecon=TextEditingController();
  bool editstate=false;
  final formKey = GlobalKey<FormState>();
  XFile? imgfile;
  bool check_active=false;


  changeeditstate()
  {
    editstate=!editstate;
    update();
  }

  checkboxavtive()
  {
    check_active=!check_active;
    update();
  }

  Navigator()
  {
    Get.to(Profile_screen(),transition: kTransition2,duration: kTransitionDuration);

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





}