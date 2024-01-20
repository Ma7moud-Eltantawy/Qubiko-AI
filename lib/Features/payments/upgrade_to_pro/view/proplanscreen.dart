import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/widgets/material_button.dart';

import '../../../../core/manager/colors_manager.dart';
import '../controller/proplacontrooler.dart';
class ProPlanScreen extends StatelessWidget {
  const ProPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Proplasncontroller controller=Get.put(Proplasncontroller());
    return Scaffold(
      appBar: AppBar(title: Text(controller.loc.translate("proplan", "sctitle")),),
      body: ListView.builder(
          itemCount: controller.ProPlansItems.length,
          itemBuilder:(context,index){
            var data=controller.ProPlansItems[index];

            return Container(
              margin: EdgeInsets.all(width/30),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(250, 250, 250, 1),
                  border: Border.all(color: data.selected?Color(0xFFFFD700):ColorsManager.burble.withOpacity(.5),width:data.selected?width/1000:width/1500),

                borderRadius: BorderRadius.circular(width/50)
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: data.colors,
                      ),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(width/50))
                    ),
              
                          height: height/7,
                          width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        data.price==0?Text(controller.loc.translate("proplan", "freetitle"),style:getBoldStyle(color: Colors.white, fontSize: width/10),):Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Text("\$${data.price}",style:getBoldStyle(color: Colors.white, fontSize: width/10),),
                            Text("/ ${data.duration}",style:getRegularStyle(color: Colors.white, fontSize: width/30),),

                          ],
                        ),
                        SizedBox(height: height/100,),
                        data.selected?Text(controller.loc.translate("proplan", "currentplan"),style: getRegularStyle(color: Colors.white, fontSize: width/30),):Text(data.description,style: getRegularStyle(color: Colors.white, fontSize: width/30),),



                      ],
                    ),
              
                        ),
              
                  Column(
                    children: data.features.map((item) => buildListItem(item)).toList(),
                  ),

                  !data.selected && data.premuimplan != PaymentPLAN.free
                      ? materialbutton(
                    height: height,
                    width: width,
                    colors: [ColorsManager.burble, ColorsManager.purble2],
                    text: controller.loc.translate("proplan", "buttontitle"),
                    onpress: () => data.onpress(),
                    textcolor: Colors.white,
                  )
                      : Container(),

                ],
              ),
            );}),
    );
  }
}

Widget buildListItem(String item) {
  return ListTile(
    leading: Container(
        child: Icon(Icons.check_box,size: width/20,)),
    title: Text(item,style: getRegularStyle(color: Colors.black87, fontSize: width/30),),
  );
}

