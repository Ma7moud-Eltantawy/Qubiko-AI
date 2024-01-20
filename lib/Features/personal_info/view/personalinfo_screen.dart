import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:quickai/Features/Auth/profile_screen/controller/profile_controller.dart';
import 'package:quickai/Features/Splash_Screen/view/Splash_screen_view.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/loadibg_widget.dart';
import 'package:quickai/widgets/material_button.dart';
import 'package:quickai/widgets/progress_hud_widget.dart';
import 'package:quickai/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/utils/functions.dart';
import '../controller/profileinfo_controller.dart';
class PersonalinfoScreen extends StatelessWidget {
  const PersonalinfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    profileinfocontrroler controller=Get.put(profileinfocontrroler());
    var loc= AppLocalizations.of(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GetBuilder<profileinfocontrroler>(
      builder:(con)=> ModalProgressHUD(
        opacity: .4,
        blur: 2,
        inAsyncCall: false,
        progressIndicator: progresshud_widget(height: height, width: width,txt: loc.translate('Login_screen', "success_msg"),
          hinttxt: loc.translate('Login_screen','hint_suc_msg'), widgetbuttom:  loadingwidget(width: width/1.8, height: height/2),
          assetimg: "assets/img/authsvg.svg",
          titlecolor: ColorsManager.green,

        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(loc.translate("personalscreen", "scname")),
           actions: [
             IconButton(
               icon:con.editstate?Icon(Icons.check,color: Colors.green,): Icon(IconBroken.Edit_Square),
               onPressed: (){
                 con.changeeditstate();
               },
             ),
           ],
          ),
          body: SingleChildScrollView(
              child:  Padding(
                padding:EdgeInsets.symmetric(
                  horizontal: width/60,
                  vertical: height/350,
                ),
                child: Form(
                  key: con.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [




                      Stack(
                        children: [
                          SizedBox(
                            height: height / 4,
                            width: width,
                            child: Card(
                              shape: const CircleBorder(),
                              color: ColorsManager.burble.withOpacity(.2),
                              child:con.imgfile == null?
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorsManager.burble.withOpacity(.3), width: width / 200),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: currentuserdata!.pic.toString(),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: ColorsManager.burble,
                                      strokeWidth: Get.width / 200,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    padding: EdgeInsets.all(Get.width / 120),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(width: Get.width / 300, color: ColorsManager.burble),
                                    ),
                                    child: Icon(
                                      Icons.error,
                                      color: ColorsManager.burble,
                                    ),
                                  ),
                                  imageBuilder: (context, imageProvider) => Container(
                                    height: Get.height/7,
                                    width: Get.width/4,
                                    decoration: BoxDecoration(

                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),),
                              )

                                  :Container(
                                decoration: BoxDecoration(
                                  image: con.imgfile == null
                                      ? const DecorationImage(
                                    image: AssetImage('assets/img/def_img.png'),
                                    fit: BoxFit.contain,
                                  )
                                      : DecorationImage(
                                    image: FileImage(File(con.imgfile!.path)),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: ColorsManager.burble.withOpacity(.3), width: width / 200),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: height / 45,
                            right: width / 4,
                            child: GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  actions: <Widget>[
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              con.Pickimagefromsource(ImageSource.camera,loc.translate("Profile_Screen", "crop_title"),);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.camera_alt_outlined,color: ColorsManager.burble,),
                                                SizedBox(width: width/30),
                                                Text(loc.translate("Profile_Screen", "camera_taken"),style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              con.Pickimagefromsource(ImageSource.gallery,loc.translate("Profile_Screen", "crop_title"),);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.image_outlined,color: ColorsManager.burble,),
                                                SizedBox(width: width/30),
                                                Text(loc.translate("Profile_Screen", "studio_taken"),style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              child: SizedBox(
                                height: height / 20,
                                width: width / 10,
                                child: Card(
                                  shape: const CircleBorder(),
                                  color: Theme.of(context).unselectedWidgetColor,
                                  child: Container(
                                    child: Center(
                                      child: Icon(IconBroken.Edit, color: Colors.white, size: width / 22),
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.burble.withOpacity(1),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: ColorsManager.burble.withOpacity(.6), width: width / 200),

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),



                      Text(loc.translate('personalscreen','nametext')),
                      SizedBox(height: height/80,),
                      text_feild(controller: con.namecon, width: width, heigh: height, hintString:currentuserdata!.name!,icon:Icon(Icons.person), texttype: TextInputType.text, password: false, seen_pass: false, readonly: !con.editstate,),
                      SizedBox(height: height/40,),
                      Text(loc.translate('personalscreen','phone')),
                      SizedBox(height: height/80,),
                      text_feild(controller: con.phonecon, width: width, heigh: height, hintString:currentuserdata!.phone!,icon: Icon(Icons.phone), texttype: TextInputType.phone, password: false, seen_pass: false,readonly: !con.editstate,),
                      SizedBox(height: height/40,),
                      Text(loc.translate('personalscreen','dateofbirth')),
                      SizedBox(height: height/80,),
                      datepickerfield(controller: con.datecon, width: width, heigh: height, hintString:currentuserdata!.DateofBirth!,icon:Icons.date_range, texttype: TextInputType.phone, password: false, seen_pass: false,readonly: true, onpress: (){
                        con.datapicker(context);
                      },),



                    ],
                  ),
                ),
              ),

            ),

        ),
      ),
    );
  }
}

