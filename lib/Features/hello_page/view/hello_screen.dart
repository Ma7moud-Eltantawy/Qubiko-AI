import 'package:get/get.dart';
import 'package:quickai/Features/Auth/Login/view/Login_screen.dart';
import 'package:quickai/Features/Auth/Sign_up/view/Signup_screen_view.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/material_button.dart';
import 'package:quickai/widgets/my_ivon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../on_boarding/view/on_boarding_screen.dart';

class Welcome_Screen extends StatelessWidget {
  const Welcome_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var loc=AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height:height ,
            width: width,
            child: Image.asset("assets/img/background.png",fit: BoxFit.fill,),
          ),
          // Other Widgets can be added on top of the background
          // For example, you can add a centered text widget:
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Center(
                child: Text(
                 loc.translate("wlcomesc", "title"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width/14,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.black,
                  ),
                ),
              ),
              SizedBox(height: height/15,),
              materialbutton(height: height, width: width,colors: [ColorsManager.burble,ColorsManager.purble2],onpress: (){
                Get.to(()=>Login_screen(),transition: kTransition2,duration: kTransitionDuration);
              },text: loc.translate("wlcomesc", "but1"),textcolor: ColorsManager.white,),
              materialbutton(height: height, width: width,colors: [ColorsManager.white,ColorsManager.white],onpress: (){
                Get.to(()=>Signup_Screen(),transition: kTransition2,duration: kTransitionDuration);

              },text: loc.translate("wlcomesc", "but2"),textcolor: ColorsManager.burble,),
              SizedBox(height: height/12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: width/3.5,child: Container(
                    height: height/380,
                    color: Colors.white,
                  ),),

                  SizedBox(width: width/3,
                  child:Text(loc.translate("wlcomesc", "contwith"),textAlign: TextAlign.center,style: TextStyle(
                    color: Colors.black54,
                    fontSize: width/30
                  ),),
                  ),


                  SizedBox(width: width/3.5,child: Container(
                    height: height/380,
                    color: Colors.white,
                  ),),

                ],
              ),
              SizedBox(height: height/20,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height/60,horizontal: width/40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconbutton(height: height, width: width,wid: Image.asset("assets/img/google.png"),onpress:(){
                      print("ok");
                    },bordercolor: Colors.white,),
                    iconbutton(height: height, width: width,wid: Image.asset("assets/img/apple-logo.png"),onpress:(){
                      print("ok");
                    },bordercolor: Colors.white,),
                    iconbutton(height: height, width: width,wid: Image.asset("assets/img/fbook.png"),onpress:(){
                      print("ok");
                    },bordercolor: Colors.white,),
                  ],
                ),
              )





            ],
          ),
        ],
      ),
    );
  }
}

