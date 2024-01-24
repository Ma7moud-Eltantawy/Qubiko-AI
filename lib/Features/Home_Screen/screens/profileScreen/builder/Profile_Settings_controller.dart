import 'dart:async';

import 'package:quickai/Features/Aboutapp/view/Aboutapp_Screen.dart';
import 'package:quickai/Features/Privacy&policy/view/privacyscreen.dart';
import 'package:quickai/Features/help_center/view/helpcenter_view.dart';
import 'package:quickai/Features/language/view/language_selected_view.dart';
import 'package:quickai/Features/security_screen/view/security_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/options/Binding.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../core/utils/functions.dart';
import '../../../../../data/Google_Ads.dart';
import '../../../../../widgets/directionicon.dart';
import '../../../../../widgets/logout_bottom_sheet.dart';
import '../../../../payments/payment_method/view/paymentsscreenview.dart';
import '../../../../payments/upgrade_to_pro/view/proplanscreen.dart';
import '../../../../personal_info/view/personalinfo_screen.dart';


class basicsitemdata{
  String hint;
  final Widget leading;
   String title;
  final Function onpress;
  final Widget traling;
  final List<Color> colors;
  final Color textcolor;

  basicsitemdata(
      {
        required this.hint,
        required this.leading,
        required this.title,
        required this.onpress,
        required this.traling,
        required this.colors,
        required this.textcolor,
      });
}
class genralItemdata{
  final Widget leading;
  final String title;
  final Function onpress;
  final Widget traling;

  genralItemdata(
      {
        required this.leading,
        required this.title,
        required this.onpress,
        required this.traling
      });
}




class profileSettingsCpntroller extends GetxController{


  late Userdatamodel userdata;
  late List<basicsitemdata> BasicsItems;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();



}
  @override
  void onReady() {


    // TODO: implement onReady
    super.onReady();
    userdata = currentuserdata!;


    print("setting_redy");
    BasicsItems=[
      basicsitemdata(
          textcolor:Colors.black ,
          hint: userdata.email!,
          leading: Container(
            height:Get.height/15,width: Get.width/5,
            child:
            CachedNetworkImage(
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
              ),
            ),
          ),
          colors: [Colors.transparent,Colors.transparent],
          title:userdata.name!, onpress: (){
        print("object");
        update();
      },
          traling: DirectionIcon(iconcolor: Colors.black,)),
      basicsitemdata(
          textcolor: Colors.white,
          hint:AppLocalizations.of(ctx).translate("mainaccount", "profilehint"),
          colors: [
            ColorsManager.burble,
            ColorsManager.burble,
            ColorsManager.burble,
            ColorsManager.purble2
          ],
          leading: Container(
            height:Get.height/15,width: Get.width/5,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/propic.png"),
                )
            ),


          ),
          title: AppLocalizations.of(ctx).translate("mainaccount", "protitle"),
          onpress: (){
            //print("object2");
            Get.to(()=>ProPlanScreen(),transition: kTransition2,duration: kTransitionDuration);
          },
          traling: DirectionIcon(iconcolor: Colors.white,))

    ];
    update();

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print("closed");
  }


  static BuildContext ctx=Get.context!;



  List<genralItemdata> Genralitems=[
    genralItemdata(
        leading: Icon(IconBroken.Profile,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item1"),
        onpress: (){
          Get.to(()=>PersonalinfoScreen(),transition: kTransition2,duration: kTransitionDuration);
        },
        traling: DirectionIcon(iconcolor: Colors.black,)),
    genralItemdata(
        leading: Icon(IconBroken.Shield_Done,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item2"),
        onpress: (){
          Get.to(()=>Securityscreen(),transition: kTransition2,duration: kTransitionDuration);

        },
        traling: DirectionIcon(iconcolor: Colors.black,)),
    genralItemdata(
        leading: Icon(IconBroken.Document,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item3"),
        onpress: (){
          Get.toNamed(Language_screen.scid);
        },
        traling: Container(
            width: Get.width/3,


            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(ctx).translate("languagesc", "lang"),style: TextStyle(
                  color: Colors.black38,
                  fontSize: Get.width/30,
                ),),
                DirectionIcon(iconcolor: Colors.black,)
              ],
            ))),


  ];
  List<genralItemdata>Aboullistitems =
  [
    genralItemdata(
        leading: Icon(IconBroken.Paper,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item4"),
        onpress: (){

          Get.toNamed(HelpCebterScreen.scid);

        },
        traling: DirectionIcon(iconcolor: Colors.black,)),
    genralItemdata(
        leading: Icon(IconBroken.Lock,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item5"),
        onpress: (){
          Get.toNamed(Privacyscreen.scid);

        },
        traling: DirectionIcon(iconcolor: Colors.black,)),
    genralItemdata(
        leading: Icon(IconBroken.More_Square,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item6"),
        onpress: (){
          Get.toNamed(AboutappScreen.scid);
        },
        traling: DirectionIcon(iconcolor: Colors.black,)),
    genralItemdata(
        leading: Icon(IconBroken.Logout,color: Colors.black,),
        title: AppLocalizations.of(ctx).translate("mainaccount", "item7"),
        onpress: (){
          Logout_bottocheet(Get.context!,height,width);
        },
        traling: DirectionIcon(iconcolor: Colors.black,)),

  ];



}