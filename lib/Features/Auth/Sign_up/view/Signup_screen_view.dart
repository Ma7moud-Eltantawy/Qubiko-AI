

import 'package:quickai/Features/Auth/Login/view/Login_screen.dart';
import 'package:quickai/Features/Auth/Sign_up/view/Signup_screen_view.dart';
import 'package:quickai/Features/Auth/profile_screen/view/profile_screen.dart';
import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/material_button.dart';
import 'package:quickai/widgets/my_ivon_button.dart';
import 'package:quickai/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/Auth/Sign_up/controller/singnup_controller.dart';

class Signup_Screen extends StatelessWidget {
   Signup_Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Signup_controller controller=Get.put(Signup_controller());
   var loc= AppLocalizations.of(context);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return GetBuilder<Signup_controller>(
      builder: (con)=>Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
              padding:EdgeInsets.symmetric(
                horizontal: width/30,
                vertical: height/350,
              ),
              child: Form(
                key: con.formKey,
                child: Column(
                  crossAxisAlignment: crossAlignment,

                  children: [
                    Text(loc.translate('signup_screen','signup_welcome'),style: TextStyle(
                      fontSize: width/16,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: height/100,),
                    Text(loc.translate('signup_screen','msg'),
                    style: TextStyle(
                      fontSize: width/25,
                      color: Colors.black54
                    ),
                    ),
                    SizedBox(height: height/20,),


                    Text(loc.translate('signup_screen','email')),
                    SizedBox(height: height/80,),

                    text_feild(controller: con.emailcon, width: width,heigh: height,hintString: loc.translate('signup_screen','email'),
                      icon: Icon(Icons.mail),password: false,seen_pass: false, texttype: TextInputType.emailAddress, readonly: false,),
                    SizedBox(height: height/40,),

                    Text(loc.translate('signup_screen','password')),
                    SizedBox(height: height/80,),
                    text_feild(controller: con.passcon, width: width,heigh: height,hintString: loc.translate('signup_screen','password'), icon: GestureDetector(child:con.check_seen?Icon(Icons.visibility):Icon(Icons.visibility_off),onTap:(){
                      con.checkpassseen();
                      print(con.check_seen);
                    } ,),password: true,seen_pass: con.check_seen, texttype: TextInputType.text,readonly: false,),
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

                              child: Text(loc.translate('signup_screen','policy'),maxLines: 2,)),
                        ),
                      ],
                    ),
                    SizedBox(height: height/60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(loc.translate('signup_screen','ask_about_login')),
                        SizedBox(width: width/50,),
                        GestureDetector(
                          onTap: (){
                            Get.off(Login_screen(),transition: kTransition2,duration: kTransitionDuration);

                          },
                          child: Container(
                              child: Text(loc.translate('signup_screen','login'),
                                style: TextStyle(
                                    fontSize: width/25,
                                    color:ColorsManager.burble2
                                ),

                              )),
                        ),

                      ],
                    ),
                    SizedBox(height: height/60,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: width/3.5,child: Container(
                          height: height/380,
                          color: ColorsManager.burble.withOpacity(.2),
                        ),),

                        SizedBox(width: width/3,
                          child:Text(loc.translate('signup_screen','continuewith'),textAlign: TextAlign.center,style: TextStyle(
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
                    SizedBox(height: height/60,),

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
        bottomNavigationBar: Container(
          width: width,
          child: materialbutton(height: height, width: width,colors: [ColorsManager.burble,ColorsManager.purble2],onpress: (){


            if (con.formKey.currentState!.validate()) {
              con.check_active?
              con.Navigator():ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.white,
                  content: Text("Chaeck about Terms & Privacy Policy ",style: TextStyle(color: ColorsManager.burble))) );



            }

          },text:loc.translate('signup_screen','continue'),textcolor: ColorsManager.white,),
        ),
      ),
    );
  }
}

