
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splash_screen extends StatelessWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var height=size.height;
    var width=size.width;
    return SafeArea(
      child: Scaffold(
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
              ShaderMask(


                shaderCallback: (bounds) {
                  return RadialGradient(
                    center: Alignment.topLeft,
                    radius: 2,
                    colors: [Color.fromRGBO(126, 146, 248, 1), Color.fromRGBO(126,146 ,248, .9),Color.fromRGBO(126,146 ,248, .8)],
                    tileMode: TileMode.repeated,
                  ).createShader(bounds);
                },
                child:   Container(
                  margin: EdgeInsets.all(width/20),
                  padding: EdgeInsets.all(width/20),

                  child: Container(
                    height: height/8,
                    width: width/4,
                    child: Opacity(
                      opacity: .9,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballSpinFadeLoader, /// Required, The loading type of the widget
                          colors: const [Colors.white],       /// Optional, The color collections
                          strokeWidth: 1,

                          backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                          pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor
                      ),
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

/*
Widget controlView() {/*
  if (DB_Helper.getUserToken() == null) {
    return LoginScreen();
  } else {
    return const HomeScreen();
  }
*/}*/

