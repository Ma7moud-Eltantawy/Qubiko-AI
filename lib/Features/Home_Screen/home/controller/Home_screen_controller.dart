import 'package:quickai/Features/Home_Screen/screens/Ai_assistant/view/Ai_Assistant_view.dart';
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Create_chat/view/Create_chat.dart';
import 'package:quickai/Features/Home_Screen/screens/History_Screen/view/History_view.dart';
import 'package:quickai/Features/Home_Screen/screens/profileScreen/view/Profile_Screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/data/DB_Helper.dart';

import '../../screens/profileScreen/builder/Profile_Settings_controller.dart';

class home_Sreen_controller extends GetxController{

  profileSettingsCpntroller profcon=Get.put(profileSettingsCpntroller());
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    update();

  }
  BaseDBhelperdatasource _baseDBhelperdatasource=RemoteDBhelperdatasource();
  List<Widget> Screen_view=[Create_chat(),AI_Assistant_Screen(),History_Screen(),ProfileSettingsView()];
  int pageposition=0;

  changePagePosition(int pos)
  {
    pageposition=pos;
    update();
  }
  updatedatabase()
   {
    //await _baseDBhelperdatasource.getuserfromDB();
    print("updated");
    profcon.onReady();
    update();

  }
}