import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/styles/icons.dart';
import '../../../main.dart';
import '../../../options/Localization_options.dart';
import '../../../widgets/directionicon.dart';
import '../controller/aboutapp_controller.dart';


class AboutappScreen extends StatelessWidget {
   AboutappScreen({Key? key}) : super(key: key);
  static String scid="/AboutappScreen";
  AboutappController controller =Get.find();

  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate("aboutsc", "sctitle")),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(child: SvgPicture.asset("assets/img/logo.svg")),
                  SizedBox(height: height/50,),
                  Text("Qubiko AI v1.0.0",style: getBoldStyle(color: Colors.black, fontSize:height/50),)
                ],
              )),
          Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:width/60),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      var item=controller.Aboutappitemlist[index];
                      return ListTile(
                        title: Text(item.title),
                        onTap: ()=>item.onpress(),
                        trailing: DirectionIcon(iconcolor: Colors.black,),
                      );
                    },
                    separatorBuilder: (context,index)=>SizedBox(height: height/1500,),
                    itemCount: controller.Aboutappitemlist.length),
              ),
          )
        ],
      ),
    );
  }
}

