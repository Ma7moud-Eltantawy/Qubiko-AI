import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickai/core/constants.dart';

import '../../../../core/manager/colors_manager.dart';
import '../../../../options/Localization_options.dart';
import '../../../../widgets/loadibg_widget.dart';
import '../../../../widgets/material_button.dart';
import '../../../../widgets/progress_hud_widget.dart';
import '../../payment_method/controller/paymentscontroller.dart';
class reviewsummaryScreen extends StatelessWidget {
  const reviewsummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
    String sckey="ReviewSummary";
    PaymentController controller=Get.put(PaymentController());

    return GetBuilder<PaymentController>(
      builder:(controller)=> ModalProgressHUD(
        opacity: .4,
        blur: 2,
        inAsyncCall: controller.progresshudstate,
        progressIndicator: progresshud_widget(height: height, width: width,txt: loc.translate('ReviewSummary', "proplantitle"),
          hinttxt: loc.translate('ReviewSummary','hintproplan'),
          widgetbuttom:materialbutton(height: height,
              width: width,
              colors: [
                ColorsManager.burble,ColorsManager.purble2,
              ],
              text:loc.translate('ReviewSummary','probutton'),
              onpress: (){
                controller.changeprogresshudstate();
              },
              textcolor: ColorsManager.white),
          assetimg: "assets/img/proplan.svg",
          titlecolor: ColorsManager.burble,


        ),

        child: Scaffold(
          appBar: AppBar(
            title: Text(loc.translate(sckey, "title")),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal:width/30,vertical: height/30 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                 decoration: BoxDecoration(
                     color: Color.fromRGBO(250, 250, 250, 1),
                     border: Border.all(color: ColorsManager.burble.withOpacity(.5),width:width/1500),
                     borderRadius: BorderRadius.circular(width/50)
                 ),

                  child: Column(
                    children: [
                      ListTile(title: Text(loc.translate(sckey, "subtitle")),trailing: Text(controller.proplandataitem.subscription.toString()),),
                      SizedBox(height: width/1500,width: width,child: Container(
                        color: ColorsManager.burble.withOpacity(.5),
                      ),),
                      ListTile(title: Text(loc.translate(sckey, "amount")),trailing: Text(controller.proplandataitem.amount.toString()),),
                      SizedBox(height: width/1500,width: width,child: Container(
                        color: ColorsManager.burble.withOpacity(.5),
                      ),),
                      ListTile(title: Text(loc.translate(sckey, "tax")),trailing: Text(controller.proplandataitem.tax.toString()),),
                      SizedBox(height: width/1500,width: width,child: Container(
                        color: ColorsManager.burble.withOpacity(.5),
                      ),),
                      ListTile(title: Text(loc.translate(sckey, "total")),trailing: Text(controller.proplandataitem.total.toString()),),
                    ],
                  ),
                ),
                Padding(

                  padding:  EdgeInsets.symmetric(vertical:height/60),
                  child: Text(loc.translate(sckey, "paymentmethod")),
                ),
                Container(
                  height: height/10,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 250, 250, 1),
                      border: Border.all(color: ColorsManager.burble.withOpacity(.5),width: width/1500),
                      borderRadius: BorderRadius.circular(width/50)
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child:SvgPicture.asset(controller.selectedpaymentmethoditem.imgAsset,fit: BoxFit.contain,),
                      radius: width/18,

                    ),
                    trailing: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Text(loc.translate(sckey, "cahngemethod"),style: TextStyle(
                          color: ColorsManager.burble
                        ),)),
                    title: Text(controller.selectedpaymentmethoditem.title),
                  ),
                ),


              ],
            ),
          ),

          bottomNavigationBar:materialbutton(height: Get.height,width: Get.width,onpress: (){
            controller.makePayment();


          },colors: [ColorsManager.burble,ColorsManager.purble2],textcolor: Colors.white,text:loc.translate(sckey, "bottomtitle") ,),
        ),
      ),
    );
  }
}
