import 'package:quickai/Features/Home_Screen/screens/profileScreen/builder/Profile_Settings_controller.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class ProfileSettingsView extends StatelessWidget {
   ProfileSettingsView({Key? key}) : super(key: key);
  profileSettingsCpntroller controller=Get.put(profileSettingsCpntroller());

  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
    final size=MediaQuery.of(context).size;
    final height=size.height;
    final width=size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:

        Text(loc.translate("mainaccount", "screentitle"),style: TextStyle(

            fontSize: width/18
        ),),
        actions: [
          Padding(
            padding:  EdgeInsets.only(
              right: width/60,
            ),
          ),
        ],
        leading: Container(
          padding: EdgeInsets.all(width/25),


          child: SvgPicture.asset("assets/img/logo.svg"),),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/30),
          child: Column(
            children: [
              GetBuilder<profileSettingsCpntroller>(
                builder:(con)=> ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.BasicsItems.length,
                  itemBuilder: (context,index)=>GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width/30),
                        gradient: LinearGradient(
                          colors: controller.BasicsItems[index].colors
                        )
                      ),
                      height: height/8,
                      child: Center(
                        child: ListTile(
                          onTap:(){controller.BasicsItems[index].onpress();},
                          title: Text(controller.BasicsItems[index].title,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          titleTextStyle: getMediumStyle(color: controller.BasicsItems[index].textcolor, fontSize: width/27),
                          trailing: controller.BasicsItems[index].traling,
                          leading: controller.BasicsItems[index].leading,
                          subtitle: Text(controller.BasicsItems[index].hint,overflow: TextOverflow.ellipsis,maxLines: 1,
                          style: getLightStyle(color: controller.BasicsItems[index].textcolor, fontSize: width/35),
                          ),

                        ),
                      ),
                    ),
                  ),

                                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/80),
                child: Row(children: [
                  Text(AppLocalizations.of(context).translate("mainaccount", "genralitems"),
                    style: getLightStyle(color: Colors.grey, fontSize: width/25),

                  ),
                  SizedBox(width: width/100,),
                  Expanded(child: SizedBox(
                    height: height/750,
                    child: Container(
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ))
                ],),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.Genralitems.length,
                itemBuilder: (context,index)=>Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width/30),
                  ),
                  height: height/16,
                  child: Center(
                    child: ListTile(
                      onTap:(){controller.Genralitems[index].onpress();},
                      title: Text(controller.Genralitems[index].title,overflow: TextOverflow.ellipsis,maxLines: 1,),
                      titleTextStyle: getMediumStyle(color: ColorsManager.black, fontSize: width/27),
                      trailing: controller.Genralitems[index].traling,
                      leading: controller.Genralitems[index].leading,

                    ),
                  ),
                ),

              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/160),
                child: Row(children: [
                  Text(AppLocalizations.of(context).translate("mainaccount", "about"),
                  style: getLightStyle(color: Colors.grey, fontSize: width/25),

                  ),
                  SizedBox(width: width/100,),
                  Expanded(child: SizedBox(
                    height: height/750,
                    child: Container(
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ))
                ],),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.Aboullistitems.length,
                itemBuilder: (context,index)=>Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width/27),
                  ),
                  height: height/16,
                  child: Center(
                    child: ListTile(
                      onTap: ()=>controller.Aboullistitems[index].onpress(),
                      title: Text(controller.Aboullistitems[index].title,overflow: TextOverflow.ellipsis,maxLines: 1,),
                      titleTextStyle: getMediumStyle(color: ColorsManager.black, fontSize: width/27),
                      trailing: controller.Aboullistitems[index].traling,
                      leading: controller.Aboullistitems[index].leading,

                    ),
                  ),
                ),

              ),



            ],
          ),
        ),
      ),
    );
  }
}
