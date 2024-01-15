import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../options/Localization_options.dart';

class Securityscreencontroller extends GetxController
{
  static BuildContext ctx=Get.context!;
  List <Securityitem>  secitems=[
    Securityitem(itemtitle:  AppLocalizations.of(ctx).translate("securityscreen", "item0"),switchval: true),
    Securityitem(itemtitle:  AppLocalizations.of(ctx).translate("securityscreen", "item1"),switchval: false),
    Securityitem(itemtitle:  AppLocalizations.of(ctx).translate("securityscreen", "item2"),switchval: false),
    Securityitem(itemtitle:  AppLocalizations.of(ctx).translate("securityscreen", "item3"),switchval: false),
    Securityitem(itemtitle:  AppLocalizations.of(ctx).translate("securityscreen", "item4"),switchval: false),


  ];


}

class Securityitem{
  final String itemtitle;
  final bool switchval;

  Securityitem({required this.itemtitle,required this.switchval});
}