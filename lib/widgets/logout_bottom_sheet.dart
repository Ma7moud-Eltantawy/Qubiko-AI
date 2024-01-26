import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/data/Auth_Helper.dart';
import 'package:quickai/data/DB_Helper.dart';
import 'package:quickai/options/Localization_options.dart';
import '../core/manager/colors_manager.dart';
import '../core/manager/text_style_manager.dart';
import '../core/styles/icons.dart';
import 'material_button.dart';
import 'package:url_launcher/url_launcher.dart';




void Logout_bottocheet(@required BuildContext context,@required double height,@required double width)
{

  BaseAuthDataSource _baseauth=AuthRemoteDataSource();
  BaseDBhelperdatasource _dbhelper=RemoteDBhelperdatasource();
  var loc=AppLocalizations.of(context);
  showFlexibleBottomSheet(
    bottomSheetBorderRadius: BorderRadius.only( topLeft: Radius.circular(width/20),
      topRight: Radius.circular(width/20),),
    minHeight: 0,
    maxHeight: .5,
    bottomSheetColor: Colors.transparent,


    builder:(contextScrollController ,scrollController,
        double bottomSheetOffset,)=> Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width/20),
                topRight: Radius.circular(width/20),
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(width/120),
            child: Column(
              children: [
                Text(
                  loc.translate("logout", "sctitle"),
                  style: TextStyle(
                    color: ColorsManager.red,
                    fontSize: width/20,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(
                    top: height/50,
                    //bottom: height/2,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: height/7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                             child:  Text(loc.translate("logout", "msg"),style:getMediumStyle(
                                 color: ColorsManager.black, fontSize: width/30)),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  materialbutton(height: height, width: width/2.5, colors: [
                                    ColorsManager.burble.withOpacity(.2),
                                    ColorsManager.purble2.withOpacity(.2)
                                  ], text:loc.translate("logout", "cancel") , onpress: (){
                                    Get.back();

                                  }, textcolor:ColorsManager.burble),
                                  materialbutton(height: height, width: width/2.5, colors: [
                                    ColorsManager.burble,
                                    ColorsManager.purble2
                                  ], text:loc.translate("logout", "logout") , onpress: (){
                                    _baseauth.logout();
                                    _dbhelper.removeuserdata();
                                    Get.offAll(()=>Welcome_Screen(),transition:kTransition2,duration: kTransitionDuration);

                                  }, textcolor: Colors.white),
                                  

                                ],
                              )
                            ),
                          ],
                        ),
                      ),



                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ), context: context,
  );

}
