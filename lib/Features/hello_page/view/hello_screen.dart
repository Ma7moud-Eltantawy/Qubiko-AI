import 'package:ai_chatbot/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../on_boarding/view/on_boarding_screen.dart';

class Welcome_Screen extends StatelessWidget {
  const Welcome_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
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
                  'Welcome to \n Qubiko AI 👋',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width/14,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.black,
                  ),
                ),
              ),
              SizedBox(height: height/15,),
              materialbutton(height: height, width: width,color: ColorsManager.burble,onpress: (){},text: "Log in",textcolor: ColorsManager.white,),
              materialbutton(height: height, width: width,color: ColorsManager.white,onpress: (){},text: "Sign up",textcolor: ColorsManager.burble,),
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
                  child:Text(" or continue with ",textAlign: TextAlign.center,style: TextStyle(
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
                    },),
                    iconbutton(height: height, width: width,wid: Image.asset("assets/img/apple-logo.png"),onpress:(){
                      print("ok");
                    },),
                    iconbutton(height: height, width: width,wid: Image.asset("assets/img/fbook.png"),onpress:(){
                      print("ok");
                    },),
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

class iconbutton extends StatelessWidget {
  const iconbutton({
    super.key,
    required this.height,
    required this.width,
    required this.wid,
    required this.onpress
  });

  final double height;
  final double width;
  final Widget wid;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onpress(),
      child: Container(
          height: height/12,
          width: width/3.5,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(width/5),
          ),
        child: Center(
          child: Container(
            height: height/24,
            width: width/7,
            child:wid,
          ),
        ),

      ),
    );
  }
}