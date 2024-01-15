import 'dart:io';

import 'package:quickai/Features/Auth/profile_screen/controller/profile_controller.dart';
import 'package:quickai/Features/Splash_Screen/view/Splash_screen_view.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/loadibg_widget.dart';
import 'package:quickai/widgets/material_button.dart';
import 'package:quickai/widgets/progress_hud_widget.dart';
import 'package:quickai/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../widgets/button_loading.dart';
class Profile_screen extends StatelessWidget {
  const Profile_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile_controller controller=Get.put(Profile_controller());
    var loc= AppLocalizations.of(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GetBuilder<Profile_controller>(
      builder:(con)=> ModalProgressHUD(
        opacity: .4,
        blur: 2,
        inAsyncCall: con.progresshudstate,
        progressIndicator: progresshud_widget(height: height, width: width,txt: loc.translate('Profile_Screen', "success_msg"),
          hinttxt: loc.translate('Profile_Screen','hint_suc_msg'), widgetbuttom:  loadingwidget(width: width/1.8, height: height/2),
          assetimg: "assets/img/authsvg.svg",
          titlecolor: ColorsManager.green,

        ),
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
              child:  Padding(
                  padding:EdgeInsets.symmetric(
                  horizontal: width/30,
                  vertical: height/350,
                ),
                  child: Form(
                    key: con.formKey,
                    child: Column(
                      crossAxisAlignment: crossAlignment,
                      children: [


                        Text(loc.translate("Profile_Screen", "title"),style: TextStyle(
                            fontSize: width/16,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: height/100,),
                        Text(loc.translate("Profile_Screen", "hint"),
                          style: TextStyle(
                              fontSize: width/25,
                              color: Colors.black54
                          ),
                        ),
                        SizedBox(height: height/20,),

                        Stack(
                          children: [
                            SizedBox(
                              height: height / 6,
                              width: width,
                              child: Card(
                                shape: const CircleBorder(),
                                color: ColorsManager.burble.withOpacity(.2),
                                child:Container(
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
                              bottom: height / 80,
                              right: width / 3.4,
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
                                child: Container(
                                  height: height / 25,
                                  width: width / 10,
                                  child: Card(
                                    shape: const CircleBorder(),
                                    color: Theme.of(context).unselectedWidgetColor,
                                    child: Container(
                                      child: Center(
                                        child: Icon(Icons.add, color: Colors.white, size: width / 22),
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



                        Text(loc.translate('Profile_Screen','name_hint')),
                        SizedBox(height: height/80,),
                        text_feild(controller: con.namecon, width: width, heigh: height, hintString:loc.translate("Profile_Screen", "name_hint"),icon: Icon(Icons.person), texttype: TextInputType.text, password: false, seen_pass: false, readonly: false,),
                        SizedBox(height: height/40,),
                        Text(loc.translate('Profile_Screen','phone_hint')),
                        SizedBox(height: height/80,),
                        text_feild(controller: con.phonecon, width: width, heigh: height, hintString:loc.translate("Profile_Screen", "phone_hint"),icon: Icon(Icons.phone), texttype: TextInputType.phone, password: false, seen_pass: false, readonly: false,),
                        SizedBox(height: height/40,),
                        Text(loc.translate('personalscreen','dateofbirth')),
                        SizedBox(height: height/80,),
                        datepickerfield(controller: con.datecon, width: width, heigh: height, hintString:loc.translate('personalscreen','dateofbirth'),icon: Icons.date_range, texttype: TextInputType.phone, password: false, seen_pass: false,readonly: true, onpress: (){
                          con.datapicker(context);
                        },),
                        SizedBox(height:height/30,),


                      ],
                    ),
                  ),
                ),

            ),
          bottomNavigationBar:con.loadingstate==true?Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: height/150),
              height: height/10,
              child: ButtonLoading()) : Container(
            height: height/10,
            width: width,
            child: materialbutton(height: height, width: width,colors:[ColorsManager.burble,ColorsManager.purble2],onpress: () async {


              if (con.formKey.currentState!.validate()) {
                if(con.datecon.text.isNotEmpty)
                  {
                    con.Navigator();
                  }
              }

            },text:loc.translate('signup_screen','continue'),textcolor: ColorsManager.white,),
          ),
        ),
      ),
    );
  }
}

