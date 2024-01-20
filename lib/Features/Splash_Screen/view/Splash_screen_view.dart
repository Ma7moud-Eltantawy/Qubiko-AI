
import 'package:quickai/Features/Splash_Screen/controller/Splash_Controller.dart';
import 'package:quickai/Features/Splash_Screen/view/Splash_screen_view.dart';
import 'package:quickai/widgets/loadibg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splash_screen extends StatelessWidget {
   Splash_screen({Key? key}) : super(key: key);
  static const scid="/Splash_screen";
  Splash_controller controller=Get.find();


  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return GetBuilder<Splash_controller>(
      init: Splash_controller(),
      builder: (con)=>Scaffold(
        backgroundColor: Colors.white,

        body: Padding(
          padding: EdgeInsets.only(top: height/8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: height/20),
                        height: height/8,
                        width: width/3,
                        child: SvgPicture.asset("assets/img/logo.svg")),
                    Text("Qubiko AI",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black,fontSize: height/25),),


                  ],
                ),
              ),
              loadingwidget(width: width, height: height),

            ],
          ),
        ),
      ),
    );
  }
}



/*
Widget controlView() {/*
  if (DB_Helper.getUserToken() == null) {
    return LoginScreen();
  } else {
    return const HomeScreen();
  }
*/}*/

