

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import '../options/Localization_options.dart';
import 'entities/proplanitems.dart';





BuildContext? ctx=Get.context;
Userdatamodel ? currentuserdata;
const kTransitionDuration = Duration(milliseconds: 300);
var width=Get.width;
var height=Get.height;
Transition kTransition1 = Transition.fadeIn;
Transition kTransition2 = Transition.rightToLeftWithFade;
TextDirection textdirection=TextDirection.LTR;
Alignment alignment=Alignment.centerLeft;
CrossAxisAlignment crossAlignment=CrossAxisAlignment.start;
const String Publishablekey="pk_test_51ORCNgGSYqhTIfqxubEIP2ffwOtiAFjntYUXIi1RrWx6ppmgF1SCtCMmGUcmuTRkivT7VEH3XGeS0Nnx61tIlzLo00lksrnLSb";
const String Secretkey ="sk_test_51ORCNgGSYqhTIfqx7YEfcEvXO3SWy0wCDjLneB40oPvcfH3GX0xe5HrrsJQfTfExxkx0xzl7xWmOGHpmVMj9RoCK00WiCwONu1";
void showsnackbar({required String content}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
   SnackBar(
  content: Text(content),
  duration: Duration(seconds: 3), // Set the duration for the snackbar
  )
  );

}


List<Proplandataitem> ProPlanDataItems=[
  Proplandataitem(
      paymentplan: PaymentPLAN.free,
      subscription: AppLocalizations.of(ctx!).translate("proplan", "freetitle"),
      amount: 0),
  Proplandataitem(
      paymentplan: PaymentPLAN.month,
      subscription: AppLocalizations.of(ctx!).translate("proplan", "duration1"),
      amount: 10),
  Proplandataitem(
      paymentplan: PaymentPLAN.halfyear,
      subscription:AppLocalizations.of(ctx!).translate("proplan", "duration2"),
      amount: 40),
  Proplandataitem(
      paymentplan: PaymentPLAN.year,
      subscription: AppLocalizations.of(ctx!).translate("proplan", "duration3"),
      amount: 70),

];