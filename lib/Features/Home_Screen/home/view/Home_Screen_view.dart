import 'package:quickai/Features/Home_Screen/home/controller/Home_screen_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/styles/icons.dart';
class Home_screen extends StatelessWidget {
  const Home_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    home_Sreen_controller controller=Get.put(home_Sreen_controller());
    return GetBuilder<home_Sreen_controller>(
      builder:(con) =>Scaffold(
        body:FutureBuilder<void>(
          future: con.updatedatabase(),
          builder:(context,snapshot)=>con.Screen_view[con.pageposition] ,
        )  ,
        bottomNavigationBar: BottomNavigationBar(

          items: [
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Category),
              label: 'AI Assistants',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Time_Circle),
              label: 'Profile',

            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Profile),
              label: 'Profile',
            ),
          ],
          currentIndex: con.pageposition,
          onTap:(index){

            con.changePagePosition(index);

          },
        ),
      ),
    );
  }
}



