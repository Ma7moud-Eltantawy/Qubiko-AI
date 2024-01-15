import 'package:quickai/options/Localization_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryItem {
  final String img;
  final String title;
  final String Searchtitle;
  final String hint;
  final Function onPressed;

  CategoryItem({
    required this.img,
    required this.title,
    required this.hint,
    required this.onPressed,
    required this.Searchtitle
  });
}
class Ai_Assistant_controller extends GetxController with GetSingleTickerProviderStateMixin {

  static BuildContext ctx=Get.context!;


  Map<String, List<CategoryItem>>? usedItems;
  Map<String, List<CategoryItem>> allItems = {
    "Writing": [
      CategoryItem(
          img: "assets/img/article.png",
          title: AppLocalizations.of(ctx).translate("Writing", "title1"),
          hint: AppLocalizations.of(ctx).translate("Writing", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Writing", "serchtitle1") ,
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/sumarrize.png",
          title: AppLocalizations.of(ctx).translate("Writing", "title2"),
          hint: AppLocalizations.of(ctx).translate("Writing", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Writing", "serchtitle2") ,

  onPressed: () {})
    ],
    "Creative": [
      CategoryItem(
          img: "assets/img/storry teller.png",
          title: AppLocalizations.of(ctx).translate("Creative", "title1"),
          hint: AppLocalizations.of(ctx).translate("Creative", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Creative", "serchtitle1"),
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/poem.png",
          title: AppLocalizations.of(ctx).translate("Creative", "title2"),
          hint: AppLocalizations.of(ctx).translate("Creative", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Creative", "serchtitle2"),
          onPressed: () {})
    ],
    "Business": [
      CategoryItem(
          img: "assets/img/emailassistant.png",
          title: AppLocalizations.of(ctx).translate("Business", "title1"),
          hint: AppLocalizations.of(ctx).translate("Business", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Business", "serchtitle1"),
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/interview.png",
          title: AppLocalizations.of(ctx).translate("Creative", "title2"),
          hint: AppLocalizations.of(ctx).translate("Creative", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Business", "serchtitle2"),
          onPressed: () {})
    ],
    "Social Media": [
      CategoryItem(
          img: "assets/img/instaassitant.png",
          title: AppLocalizations.of(ctx).translate("Social Media", "title1"),
          hint: AppLocalizations.of(ctx).translate("Social Media", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Social Media", "serchtitle1"),
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/linkedinass.png",
          title: AppLocalizations.of(ctx).translate("Social Media", "title2"),
          hint: AppLocalizations.of(ctx).translate("Social Media", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Social Media", "serchtitle2"),
          onPressed: () {})
    ],
    "Developer": [
      CategoryItem(
          img: "assets/img/write code.png",
          title: AppLocalizations.of(ctx).translate("Developer", "title1"),
          hint: AppLocalizations.of(ctx).translate("Developer", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Developer", "serchtitle1"),
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/explaincode.png",
          title: AppLocalizations.of(ctx).translate("Developer", "title2"),
          hint: AppLocalizations.of(ctx).translate("Developer", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Developer", "serchtitle2"),
          onPressed: () {})
    ],
    "Personal": [
      CategoryItem(
          img: "assets/img/birthday.png",
          title: AppLocalizations.of(ctx).translate("Personal", "title1"),
          hint: AppLocalizations.of(ctx).translate("Personal", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Personal", "serchtitle1"),
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/apology.png",
          title: AppLocalizations.of(ctx).translate("Personal", "title2"),
          hint: AppLocalizations.of(ctx).translate("Personal", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Personal", "serchtitle2"),
          onPressed: () {})
    ],
    "Others": [
      CategoryItem(
          img: "assets/img/creativeconversation.png",
          title: AppLocalizations.of(ctx).translate("Others", "title1"),
          hint: AppLocalizations.of(ctx).translate("Others", "hint1"),
          Searchtitle:AppLocalizations.of(ctx).translate("Others", "serchtitle1"),
          onPressed: () {}),
      CategoryItem(
          img: "assets/img/jok.png",
          title: AppLocalizations.of(ctx).translate("Others", "title2"),
          hint: AppLocalizations.of(ctx).translate("Others", "hint2"),
          Searchtitle:AppLocalizations.of(ctx).translate("Others", "serchtitle2"),
          onPressed: () {})
    ],
  };
  AppLocalizations loc= AppLocalizations.of(ctx);
  String Getitemtitle(String collection ,String key)
  {
    return loc.translate(collection,key);
  }

  late TabController controller;
  List<String> assistant_cat=[
    "All","Writing","Creative","Business","Social Media","Developer","Personal","Others"
  ];
  int assistant_pos=0;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 4,initialIndex: 0);
    usedItems=allItems;
    update();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
  changeposition_assistant({required int index,required String collectionname})
  {
    assistant_pos=index;
    changeuseditem(collection: collectionname);
    update();
  }


  void changeuseditem({required String collection}) {
    if(collection=="All")
      {
        usedItems = allItems;
        update();
      }
    else{
      usedItems = {collection: allItems[collection]!};
      update();
    }


  }


}
