import 'package:quickai/Features/Home_Screen/screens/Ai_assistant/controller/Ai_assistant_con.dart';
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Chat/view/chat_view.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../core/utils/functions.dart';
import '../../../../../../data/Google_Ads.dart';
class Create_chat extends StatelessWidget {
  const Create_chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ai_Assistant_controller controller=Get.put(Ai_Assistant_controller());
    var loc=AppLocalizations.of(context);
    var size=MediaQuery.of(context).size;
    var width=size.width;
    var height=size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Qubiko AI "),
        leading: Container(
            padding: EdgeInsets.all(width/25),

            child: SvgPicture.asset("assets/img/logo.svg"),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            height: height/5,
            width: width,
            color: Colors.transparent,

            child: SvgPicture.asset("assets/img/logo.svg"),),
          SizedBox(height: height/30,),
          Text(loc.translate("createchat", "title"),style: TextStyle(
            fontSize: width/12,

            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: height/30,),
          Text(loc.translate("createchat", "hint"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width/24,

              fontWeight: FontWeight.w300
          ),),
          SizedBox(height: height/20
          ),
          materialbutton(height: height, width: width,colors: [ColorsManager.burble,ColorsManager.purble2],onpress: (){




            Get.to(()=>Chat_screen(msgsdata:[],docid:"",searchtitle:"",),transition: kTransition2,duration: kTransitionDuration);



          },text:loc.translate('createchat','buttontitle'),textcolor: ColorsManager.white,),



        ],
      ),
    );
  }
}
