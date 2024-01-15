import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/security_screen/controller/security_screen_controller.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/widgets/material_button.dart';

import '../../../options/Localization_options.dart';
class Securityscreen extends StatelessWidget {
  const Securityscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
    Securityscreencontroller controller=Get.put(Securityscreencontroller());
    return Scaffold(
      appBar:AppBar(
        title: Text(loc.translate("securityscreen", "sctitle")),
      ) ,
      body: Column(
        children: [
          Container(
            height: height/2.6,
            child: ListView.builder(
              itemCount: controller.secitems.length,
                itemBuilder:(context,index)=>ListTile(title:Text(controller.secitems[index].itemtitle) ,
                trailing: Switch(
                  value: controller.secitems[index].switchval, onChanged: (bool value) {  },
                  activeTrackColor: ColorsManager.burble,
                  inactiveThumbColor: ColorsManager.white,
                  inactiveTrackColor: Colors.grey.shade300,
                  trackOutlineColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      return Colors.transparent; // Default color
                    },
                  ),
            
            
                ),
            
            
                )
            ),
          ),

          materialbutton(height: height, width: width, colors: [ColorsManager.burble.withOpacity(.2),ColorsManager.burble.withOpacity(.2)], text: loc.translate("securityscreen", "chpass"), onpress: (){
            
          }, textcolor: ColorsManager.burble)
        ],
      ),
    );
  }
}
