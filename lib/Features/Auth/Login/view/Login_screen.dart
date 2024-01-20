

import 'package:quickai/Features/Auth/Login/controller/login_controller.dart';
import 'package:quickai/Features/Auth/Sign_up/view/Signup_screen_view.dart';
import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/button_loading.dart';
import 'package:quickai/widgets/material_button.dart';
import 'package:quickai/widgets/my_ivon_button.dart';
import 'package:quickai/widgets/progress_hud_widget.dart';
import 'package:quickai/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/Auth/Sign_up/controller/singnup_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../widgets/loadibg_widget.dart';

class Login_screen extends StatelessWidget {
  Login_screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Login_controller controller=Get.put(Login_controller());
    var loc= AppLocalizations.of(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GetBuilder<Login_controller>(
      builder:(con)=> ModalProgressHUD(
        opacity: .4,
        blur: 2,
        inAsyncCall: con.progresshudstate,
        progressIndicator: progresshud_widget(height: height, width: width,txt: loc.translate('Login_screen', "success_msg"),
          hinttxt: loc.translate('Login_screen','hint_suc_msg'), widgetbuttom:  loadingwidget(width: width/1.8, height: height/2),
          assetimg: "assets/img/authsvg.svg",
          titlecolor: ColorsManager.green,


        ),
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width/60),
            child: SingleChildScrollView(
              child: GetBuilder<Login_controller>(
                  builder:(con)=> Padding(
                    padding:EdgeInsets.symmetric(
                      horizontal: width/60,
                      vertical: height/350,
                    ),
                    child: Form(
                      key: con.loginformKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(loc.translate('Login_screen','signup_welcome'),style: TextStyle(
                              fontSize: width/16,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: height/100,),
                          Text(loc.translate('Login_screen','msg'),
                            style: TextStyle(
                                fontSize: width/25,
                                color: Colors.black54
                            ),
                          ),
                          SizedBox(height: height/30,),


                          Text(loc.translate('Login_screen','email')),
                          SizedBox(height: height/80,),

                          text_feild(controller: con.emailcon, width: width,heigh: height,hintString: loc.translate('signup_screen','email'),
                            icon:Icon(Icons.mail),password: false,seen_pass: false, texttype: TextInputType.emailAddress, readonly: false,),
                          SizedBox(height: height/40,),

                          Text(loc.translate('Login_screen','password')),
                          SizedBox(height: height/80,),
                          text_feild(controller: con.passcon, width: width,heigh: height,hintString: loc.translate('signup_screen','password'), icon: GestureDetector(child:con.check_seen?Icon(Icons.visibility):Icon(Icons.visibility_off),onTap:(){
                            con.checkpassseen();
                            print(con.check_seen);
                          } ,),password: true,seen_pass: true, texttype: TextInputType.text,readonly: false,),
                          SizedBox(height: height/30,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: con.check_active,
                                onChanged: (bool? value) {
                                  con.checkboxavtive();

                                },
                                checkColor: ColorsManager.white,
                                activeColor: ColorsManager.burble,

                              ),
                              Expanded(
                                child: Container(
                                    child: Text(loc.translate('Login_screen','remember'),maxLines: 2,)),
                              ),
                            ],
                          ),
                          SizedBox(height: height/100,),
                          InkWell(
                            onTap: (){

                            },
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(loc.translate('Login_screen','ask_about_pass'),textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorsManager.burble2
                                ),)),
                          ),
                          SizedBox(height: height/50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(loc.translate('Login_screen','ask_about_signup')),
                              SizedBox(width: width/50,),
                              GestureDetector(
                                onTap: (){
                                  Get.off(Signup_Screen(),transition: kTransition2,duration: kTransitionDuration);

                                },
                                child: Container(
                                    child: Text(loc.translate('Login_screen','signup'),
                                      style: TextStyle(
                                          fontSize: width/25,
                                          color:ColorsManager.burble2
                                      ),

                                    )),
                              ),

                            ],
                          ),
                          SizedBox(height: height/50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: width/3.5,child: Container(
                                height: height/380,
                                color: ColorsManager.burble.withOpacity(.2),
                              ),),

                              SizedBox(width: width/3,
                                child:Text(loc.translate('Login_screen','continuewith'),textAlign: TextAlign.center,style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: width/30
                                ),),
                              ),


                              SizedBox(width: width/3.5,child: Container(
                                height: height/380,
                                color:  ColorsManager.burble.withOpacity(.2),
                              ),),

                            ],
                          ),
                          SizedBox(height: height/50,),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: height/60,horizontal: width/40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                iconbutton(height: height, width: width,wid: Image.asset("assets/img/google.png"),onpress:(){
                                  print("ok");
                                },bordercolor: ColorsManager.burble,),
                                iconbutton(height: height, width: width,wid: Image.asset("assets/img/apple-logo.png"),onpress:(){
                                  print("ok");
                                },bordercolor: ColorsManager.burble,),
                                iconbutton(height: height, width: width,wid: Image.asset("assets/img/fbook.png"),onpress:(){
                                  print("ok");
                                },bordercolor: ColorsManager.burble,),
                              ],
                            ),
                          ),



                        ],


                      ),
                    ),
                  ),

              ),
            ),
          ),
          bottomNavigationBar:con.loadingstate==true?Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: height/150),
              height: height/10,
              child: ButtonLoading()):Container(
            height: height/10,
            child: materialbutton(height: height, width: width,colors: [ColorsManager.burble,ColorsManager.purble2],onpress: (){


              if (con.loginformKey.currentState!.validate() && con.check_active) {
                con.login(ctx: context, height: height, width: width);
              }

            },text:loc.translate('Login_screen','continue'),textcolor: ColorsManager.white,),
          ) ,
        ),
      ),
    );
  }
}

