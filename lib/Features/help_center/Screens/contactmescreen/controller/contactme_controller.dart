import 'dart:io';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../options/Localization_options.dart';

class ContatctmeController extends GetxController{
  List<contactitem> listItems=[
    contactitem(imgpath: "assets/img/whatsappicon.svg", title:AppLocalizations.of(Get.context!).translate("contactus", "title0"), onpress: () async {
        if (!await launchUrl(Uri.parse("https://wa.me/+201015876911"))) {
          throw Exception('Could not launch');
        }
    }),
    contactitem(imgpath: "assets/img/instaicon.svg",
        title:AppLocalizations.of(Get.context!).translate("contactus", "title1"),
        onpress: () async {
          if (!await launchUrl(Uri.parse("https://www.instagram.com/your_username"))) {
            throw Exception('Could not launch');
          }}),
    contactitem(imgpath: "assets/img/facebookicon.svg", title:AppLocalizations.of(Get.context!).translate("contactus", "title2"),
        onpress: () async {
          if (!await launchUrl(Uri.parse("https://www.facebook.com/facebookUsername"))) {
            throw Exception('Could not launch');
          }}),
    contactitem(imgpath: "assets/img/twittericon.svg", title:AppLocalizations.of(Get.context!).translate("contactus", "title3"), onpress: () async {
      if (!await launchUrl(Uri.parse("https://twitter.com/your_username"))) {
        throw Exception('Could not launch');
      }}),
    contactitem(imgpath: "assets/img/websiteicon.svg", title:AppLocalizations.of(Get.context!).translate("contactus", "title4"), onpress: () async {
      if (!await launchUrl(Uri.parse("https://www.linkedin.com/in/your_profile"))) {
        throw Exception('Could not launch');
      }}),

  ];




}



class contactitem{
  String imgpath;
  String title;
  Function onpress;

  contactitem({
    required this.imgpath,
    required this.title,
    required this.onpress,

});

}