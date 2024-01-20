import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/enums.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/DB_Helper.dart';
import '../../../options/Localization_options.dart';

class LanguageController extends GetxController{

  late String DBlang;
  int selecteditem=0;
  BaseDBhelperdatasource dBhelperdatasource=RemoteDBhelperdatasource();

  @override

  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("on init");
    await getlangfromdb().then((value){
      DBlang=value;
      value=="en"?selecteditem=0:selecteditem=1;
      print(DBlang);
      update();
    });

  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }
  var laocals=[
  Locale('en', 'US'),
  Locale('ar', 'EG'),
  ];

  var currentLocale = Locale('en', 'US').obs;

  void changeLanguage(Locale newLocale) {
    currentLocale.value = newLocale;
    print(currentLocale.toString());
    // Add any other logic you may need when changing the language
    update();
  }

  String translate(String collection, String key) {
    return AppLocalizations.of(Get.context!).translate(collection, key);
  }



  List<Languageitem> Languagelistitems=[
        Languageitem(itemtitle: "English (US)"),
        Languageitem(itemtitle:"(مصر) العربيه"),

    ];

  Changeselectedlang(int val)
  async {

    selecteditem=val;
    changeLanguage(laocals[val]);
    print(translate("languagesc", "sctitle"));
    Restart.restartApp();

    if(val==0) {
      dBhelperdatasource.SavelanginDB(lang:"en");
    }
    else{
      dBhelperdatasource.SavelanginDB(lang:"ar");
    }

    update();

  }


  Future<String>  getlangfromdb()
  async {
    String returnval="";

    await dBhelperdatasource.getlangfromDB().then((value) async {
      if(value.requestState==RequestState.success)
        {
          returnval=value.data!;
          print(returnval);
        }
      else{
        await dBhelperdatasource.SavelanginDB(lang:"en");
        returnval=await getlangfromdb();
        print(returnval);
      }


    });
    return returnval;

  }




}

class Languageitem{
  final String itemtitle;

  Languageitem({

    required this.itemtitle,

});





}