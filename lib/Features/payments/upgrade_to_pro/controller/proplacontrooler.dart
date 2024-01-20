import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/payments/payment_method/view/paymentsscreenview.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';

import '../../../../core/enums.dart';
import '../../../../options/Localization_options.dart';



class Proplasncontroller extends GetxController
{
  static BuildContext ctx=Get.context!;
  late PaymentPLAN paymentplan;
  List<proplanitem> ProPlansItems=[];

  @override
  void onInit() {

    // TODO: implement onInit
    super.onInit();
    paymentplan=PaymentPLAN.free;
    initialitems();

  }




  var loc=AppLocalizations.of(ctx);
  void initialitems() {
    ProPlansItems = [
      proplanitem(
        premuimplan: PaymentPLAN.free,
          selected: getselectedornot(PaymentPLAN.free),
          onpress: (){


          },
          colors: [
            Color.fromRGBO(18, 165, 117, 1),
            Color.fromRGBO(18, 165, 117, 1),
          ],
          price: int.parse(
              AppLocalizations.of(ctx).translate("proplan", "price0")),
          duration: "",
          description: AppLocalizations.of(ctx).translate(
              "proplan", "description0"),
          features: AppLocalizations.of(ctx).translate(
              "proplan", "freefeatures").split(",").toList()
      ),
      proplanitem(
          premuimplan: PaymentPLAN.month,
          selected:getselectedornot(PaymentPLAN.month),
          onpress: (){
            paymentplan=PaymentPLAN.month;
            print(paymentplan.toString());
            update();
            Get.to(()=>Paymentmethodscreen(),transition: kTransition2,duration: kTransitionDuration);
          },
          colors: [
            Color.fromRGBO(166, 201, 255, 1),
            Color.fromRGBO(94, 182, 245, 1),
          ],
          price: int.parse(
              AppLocalizations.of(ctx).translate("proplan", "price1")),
          duration: AppLocalizations.of(ctx).translate("proplan", "duration1"),
          description: AppLocalizations.of(ctx).translate(
              "proplan", "description1"),
          features: AppLocalizations.of(ctx).translate(
              "proplan", "paidfeatures").split(",").toList()
      ),
      proplanitem(
          premuimplan: PaymentPLAN.halfyear,
          selected: getselectedornot(PaymentPLAN.halfyear),
          onpress: (){
            paymentplan=PaymentPLAN.halfyear;
            print(paymentplan.toString());
            update();
            Get.to(()=>Paymentmethodscreen(),transition: kTransition2,duration: kTransitionDuration);
          },
          colors: [
            Color.fromRGBO(255, 174, 212, 1),
            Color.fromRGBO(255, 92, 170, 1),
          ],
          price: int.parse(
              AppLocalizations.of(ctx).translate("proplan", "price2")),
          duration: AppLocalizations.of(ctx).translate("proplan", "duration2"),
          description: AppLocalizations.of(ctx).translate(
              "proplan", "description2"),
          features: AppLocalizations.of(ctx).translate(
              "proplan", "paidfeatures").split(",").toList()
      ),
      proplanitem(
          premuimplan: PaymentPLAN.year,
          onpress: (){
          paymentplan=PaymentPLAN.year;
          print(paymentplan.toString());
          update();
          Get.to(()=>Paymentmethodscreen(),transition: kTransition2,duration: kTransitionDuration);

        },
          selected: getselectedornot(PaymentPLAN.year),
          colors: [
            Color.fromRGBO(172, 154, 252, 1),
            Color.fromRGBO(148, 126, 253, 1),
          ],
          price: int.parse(
              AppLocalizations.of(ctx).translate("proplan", "price3")),
          duration: AppLocalizations.of(ctx).translate("proplan", "duration3"),
          description: AppLocalizations.of(ctx).translate(
              "proplan", "description3"),
          features: AppLocalizations.of(ctx).translate(
              "proplan", "paidfeatures").split(",").toList()
      ),
    ];
  }



  bool getselectedornot(PaymentPLAN plan)
  {
    print("current:${currentuserdata!.Premuimplan}");

    if(currentuserdata!.Premuimplan==plan.toString())
      {
        return true;
      }
    else
      {
        return false;
      }

  }

}




class proplanitem{
  final int price;
  final List<Color> colors;
  final String duration;
  final String description;
  final List<String> features;
  bool selected;
  final Function onpress;
  final PaymentPLAN premuimplan;

  proplanitem( {
    required this.onpress,
    required this.selected,
    required this.colors,
    required this.price,
    required this.duration,
    required this.description,
    required this.features,
    required this.premuimplan,
  });
}