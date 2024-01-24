import 'package:quickai/Features/Home_Screen/home/controller/Home_screen_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/options/Localization_options.dart';
class Home_screen extends StatelessWidget {
  const Home_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
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
              label: loc.translate("apphomescs", "sc1"),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Category),
              label: loc.translate("apphomescs", "sc2"),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Time_Circle),
              label: loc.translate("apphomescs", "sc3"),

            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Profile),
              label: loc.translate("apphomescs", "sc4"),
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



