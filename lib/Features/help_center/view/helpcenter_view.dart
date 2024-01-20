import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/manager/colors_manager.dart';

import '../../../options/Localization_options.dart';
import '../Screens/FaqsScreen/view/faqsscreen.dart';
import '../Screens/contactmescreen/controller/contactme_controller.dart';
import '../Screens/contactmescreen/view/contactmeScreen.dart';
import '../controller/helpcenter_controller.dart';
class HelpCebterScreen extends StatelessWidget {
  HelpCebterScreen({Key? key}) : super(key: key);
  static const scid="/helpcenterscreenscid";


  helpcentercontroller controller=Get.find<helpcentercontroller>();
  @override
  Widget build(BuildContext context) {

    var loc=AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Tab(text: loc.translate("helpcenter", "mainsctitle")),
          bottom:TabBar(
            dividerColor: ColorsManager.burble.withOpacity(.1),
            indicatorColor: ColorsManager.burble,
            indicatorSize: TabBarIndicatorSize.tab,

            tabs: [
              Tab(text: loc.translate("helpcenter", "sctitle1")),
              Tab(text: loc.translate("helpcenter", "sctitle2")),
            ],
            onTap: (index) {
              controller.tabIndex.value = index;
            },
          ),
        ),
        body: TabBarView(
          children: [
            Faqsscreen(),
            ContactmeScreen(),          ],
        ),
      ),
    );
  }
}
