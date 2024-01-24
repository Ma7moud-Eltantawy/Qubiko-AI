import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show AlertDialog, BuildContext, Color, Colors, Container, Navigator, ScaffoldMessenger, SnackBar, TextStyle, showDialog;
import 'package:get/get.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:toast/toast.dart';

import '../entities/proplanitems.dart';
import '../enums.dart';
import '../enums.dart';
import '../manager/colors_manager.dart';


snackBarError(String error) {
  Get.snackbar(
    'Failed',
    error,
    backgroundColor: ColorsManager.errorBG,
    colorText: ColorsManager.errorText,
  );
}

snackBarSuccess(String error) {
  Get.snackbar(
    'Success',
    error,
    backgroundColor: ColorsManager.purble2,
    colorText: ColorsManager.white,
    snackPosition: SnackPosition.BOTTOM
  );
}

getNameFromEmail(String email) {
  return email.split('@').first;
}

bool isPositive(String value) {
  final num = int.parse(value);
  return num > 0;
}

Proplandataitem getproplandata({required PaymentPLAN plan})
{
  print(plan);

  return ProPlanDataItems.firstWhere((element) => element.paymentplan==plan);

}

void showdatePicker({required BuildContext context, required TextEditingController textcon}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: width/3,
          height: height/2,
          // Use a Column to wrap your content and apply constraints.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded is used inside a Column to take available vertical space.
              Expanded(
                child: SfDateRangePicker(
                  view: DateRangePickerView.year,
                  selectionMode: DateRangePickerSelectionMode.single,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    print(args.value);
                    textcon.text = args.value.toString().split(" ").first;

                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}



bool Checkpremuimdate({required DateTime date})
{
  DateTime currentDate = DateTime.now();
  DateTime targetDate = date; // Year, Month, Day
  if (targetDate.isAfter(currentDate)) {
    print('Target date is after the current date.');
    return true;
  } else {
    return false;
  }

}

void showsnackbar({required String content}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(content,style:getRegularStyle(color: ColorsManager.burble, fontSize: width/40)),
        duration: Duration(seconds: 3), // Set the duration for the snackbar
      )
  );

}



