
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/widgets/material_button.dart';

import '../../../../core/enums.dart';
import '../../../../widgets/circylar_check_box.dart';
import '../controller/paymentscontroller.dart';
class Paymentmethodscreen extends StatelessWidget {
   Paymentmethodscreen({Key? key}) : super(key: key);

  PaymentController controller=Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder:(con)=> Scaffold(
        appBar: AppBar(
          title: Text("Select Payment Method"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width/30),
          child: ListView.separated(
            separatorBuilder: (context,index)=>SizedBox(height: Get.height/60,),
            itemCount: controller.paymentItems.length,
              itemBuilder: (context,index)=>
                  Container(
                    height: Get.height/10,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 250, 250, 1),
                      border: Border.all(color: ColorsManager.burble.withOpacity(.5),width: Get.width/1500),
                      borderRadius: BorderRadius.circular(Get.width/50)
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child:SvgPicture.asset(controller.paymentItems[index].imgAsset,fit: BoxFit.contain,),
                        radius: Get.width/18,

                      ),
                      trailing: CircularCheckbox(
                        value:controller.paymentItems[index].checkboxState ,
                        onChanged: (value){
                          controller.changeIndexCheck(index,value!);

                        },
                      ),
                      title: Text(controller.paymentItems[index].title),
                    ),
                  ),



          ),
        ),
        bottomNavigationBar:materialbutton(height: Get.height,width: Get.width,onpress: (){
            controller.continuepayment();


        },colors:controller.selectedPaymentMethod == PaymentMethod.nopay?[ColorsManager.grey.withOpacity(0.5),ColorsManager.burble]: [ColorsManager.burble,ColorsManager.purble2],textcolor: Colors.white,text: "continue",),
      ),
    );
  }
}
