import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/loadibg_widget.dart';
import 'package:flutter/material.dart';

class progresshud_widget extends StatelessWidget {
  const progresshud_widget({
    super.key,
    required this.height,
    required this.width,
    required this.txt, required this.hinttxt, required this.assetimg, required this.widgetbuttom, required this.titlecolor,

  });

  final double height;
  final double width;
  final String txt;
  final String hinttxt;
  final String assetimg;
  final Widget widgetbuttom;
  final Color titlecolor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
            margin: EdgeInsets.all(width/30),
            padding: EdgeInsets.all(width/30),
            height: height/1.7,
            width: width/1.25,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width/10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: height/3,
                    child: SvgPicture.asset(assetimg)),
                Text(txt,textAlign: TextAlign.center,style:getBoldStyle(color: titlecolor, fontSize: width/25)),
                Text(hinttxt,textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorsManager.black,
                      fontSize: width/35
                  ),


                ),
                widgetbuttom,

              ],
            ),
          )),
    );
  }
}
