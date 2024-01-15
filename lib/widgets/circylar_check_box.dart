import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/styles/icons.dart';

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CircularCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: ClipOval(
        child: Container(
          width: Get.width/18, // Adjust the size as needed
          height: Get.height/40, // Adjust the size as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorsManager.burble,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            width: Get.width/25,
            height: Get.height/60,
            child: value? Center(
              child:Icon(Icons.check,size: Get.width/30,color: Colors.white,),
            ):Container(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? ColorsManager.burble : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
