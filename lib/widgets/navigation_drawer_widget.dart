import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/styles/icons.dart';

import '../Features/Home_Screen/home/controller/Home_screen_controller.dart';
import '../options/Localization_options.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    home_Sreen_controller controller=Get.put(home_Sreen_controller());
    return GetX<home_Sreen_controller>(
      builder: (controller) {
        var loc = AppLocalizations.of(context);

        return Container(
          width: MediaQuery.of(context).size.width * 0.75,
          color: ColorsManager.burble.withOpacity(.05),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: height/10,),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    DrawerItem(
                      title: loc.translate("apphomescs", "sc1"),
                      currentPos: controller.pageposition.value,
                      icon: IconBroken.Chat,
                      onTap: () {

                        controller.changePagePosition(0);
                      },
                      pagePos: 0,
                    ),
                    SizedBox(height: height/50,),
                    DrawerItem(
                      title: loc.translate("apphomescs", "sc2"),
                      currentPos: controller.pageposition.value,
                      icon: IconBroken.Category,
                      onTap: () {
                        controller.changePagePosition(1);
                      },
                      pagePos: 1,
                    ),
                    SizedBox(height: height/50,),
                    DrawerItem(
                      title: loc.translate("apphomescs", "sc3"),
                      currentPos: controller.pageposition.value,
                      icon: IconBroken.Time_Circle,
                      onTap: () {
                        controller.changePagePosition(2);
                      },
                      pagePos: 2,
                    ),

                    SizedBox(height: height/50,),
                    DrawerItem(
                      title: loc.translate("apphomescs", "sc4"),
                      currentPos: controller.pageposition.value,
                      icon: IconBroken.Profile,
                      onTap: () {
                        controller.changePagePosition(3);
                      },
                      pagePos: 3,
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    ListTile(
                      title: Text(
                        "Logout",
                        style: getMediumStyle(
                          color: Colors.red,
                          fontSize: width / 40,
                        ),
                      ),
                      leading: Icon(
                        IconBroken.Logout,
                        size: width / 27,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.pagePos,
    required this.currentPos,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;
  final int pagePos;
  final int currentPos;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      title: Text(
        title,
        style: getRegularStyle(color: pagePos == currentPos?ColorsManager.burble:Colors.black54, fontSize: width / 40),
      ),
      leading: Icon(icon, size: width / 30,color: pagePos == currentPos?ColorsManager.burble:Colors.black54,),
      trailing: pagePos == currentPos
          ? Container(
        color: ColorsManager.burble,
        width: width / 500,
      )
          : null,
    );
  }
}
