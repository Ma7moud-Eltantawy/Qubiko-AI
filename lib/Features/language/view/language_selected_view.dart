import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/language/controller/language_controller.dart';
import 'package:quickai/core/constants.dart';

import '../../../options/Localization_options.dart';
class Language_screen extends StatelessWidget {
   Language_screen({Key? key}) : super(key: key);
  static const scid="/Language_screen";
  LanguageController controller=Get.find();

  @override
  Widget build(BuildContext context) {
    var loc= AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate("languagesc", "sctitle")),
      ),
      body: GetBuilder<LanguageController>(
        builder:(con)=> ListView.separated(
            itemBuilder: (context,index)=>GestureDetector(
              onTap: (){
                controller.Changeselectedlang(index);
              },
              child: ListTile(
                title: Text(controller.Languagelistitems[index].itemtitle),
                trailing:controller.selecteditem==index?Icon(Icons.check,color: Colors.green,):SizedBox() ,
              ),
            ),
            separatorBuilder: (context,index)=>SizedBox(height: height/30,),
            itemCount: controller.Languagelistitems.length),
      ),
    );
  }
}
