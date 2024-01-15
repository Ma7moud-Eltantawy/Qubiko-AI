import 'package:quickai/Features/Home_Screen/home/controller/Home_screen_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Home_screen extends StatelessWidget {
  const Home_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    home_Sreen_controller controller=Get.put(home_Sreen_controller());
    return GetBuilder<home_Sreen_controller>(
      builder:(con) =>Scaffold(
        body:con.Screen_view[con.pageposition],
        bottomNavigationBar: BottomNavigationBar(

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'AI Assistants',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Profile',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
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



