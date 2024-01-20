import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quickai/core/constants.dart';

import '../controller/contactme_controller.dart';
class ContactmeScreen extends StatelessWidget {
   ContactmeScreen({Key? key}) : super(key: key);
   static String scid="/ContactmeScreen";
  ContatctmeController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: height/50),
          child: ListView.separated(
              itemBuilder:(context,index)=>GestureDetector(
                onTap:()=>controller.listItems[index].onpress() ,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width/30),
                  padding: EdgeInsets.symmetric(horizontal: width/30,vertical: height/120),
                  decoration:BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.2),width: width/300),
                    borderRadius: BorderRadius.circular(width/30),
                  ),
                  child: ListTile(
                    title:Text(controller.listItems[index].title) ,
                    leading: SvgPicture.asset(controller.listItems[index].imgpath),

                  ),
                ),
              )

              , separatorBuilder: (context,index)=>SizedBox(height: height/60,)
              , itemCount: controller.listItems.length),
        ),
      ),
    );
  }
}
