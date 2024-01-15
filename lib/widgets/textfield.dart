import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../core/utils/functions.dart';

class text_feild extends StatelessWidget {
  text_feild({
    super.key,
    required this.controller, required this.width, required this.heigh, required this.hintString, required this.icon, required this.texttype, required this.password, required this.seen_pass, required this.readonly,


  });
  final TextEditingController controller;
  final double width;
  final double heigh;
  final String hintString;
  final Widget icon;
  final TextInputType texttype;
  final bool password;
  final bool seen_pass;
  final bool readonly;


  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    return Container(

      width: width,
      child: TextFormField(
        readOnly: readonly,
        obscureText: password?seen_pass:false,
        controller: controller,
        cursorColor: ColorsManager.burble,
        keyboardType: texttype,

        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width/30
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
              fontSize: width/60,
              color: ColorsManager.red.withOpacity(.6),
              fontWeight: FontWeight.w600
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: width/16),

          filled: true,
          fillColor: Colors.grey[100], // Gray background color
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width/15),
            borderSide: BorderSide(color: Colors.grey[200]!), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width/15),
            borderSide: BorderSide(color:readonly?Colors.grey[200]!: ColorsManager.burble), // Active (focused) border color
          ),
          errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(width/15),
        borderSide: BorderSide(color: ColorsManager.red.withOpacity(.6)), // Active (focused) border color
            ) ,
          focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(width/15),
        borderSide: BorderSide(color: ColorsManager.burble), // Active (focused) border color
      ),
          hintText: hintString,
          hintStyle: TextStyle(
              color: Colors.grey[400]
          ),
          suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: width/30),
              child: icon), // Default prefix icon color
          suffixIconColor: ColorsManager.burble, // Active (focused) prefix icon color
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Data.';
          }
          return null;
        },

      ),
    );
  }
}


class datepickerfield extends StatelessWidget {
  datepickerfield({
    super.key,
    required this.controller,
    required this.width,
    required this.heigh,
    required this.hintString,
    required this.icon,
    required this.texttype,
    required this.password,
    required this.seen_pass,
    required this.readonly,
    required this.onpress,

  });

  final TextEditingController controller;
  final double width;
  final double heigh;
  final String hintString;
  final IconData icon;
  final TextInputType texttype;
  final bool password;
  final bool seen_pass;
  final bool readonly;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: width,
      child: TextFormField(
        readOnly: readonly,
        obscureText: password ? seen_pass : false,
        controller: controller,
        cursorColor: ColorsManager.burble,
        keyboardType: texttype,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: width / 30,
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontSize: width / 40,
            color: ColorsManager.red.withOpacity(.6),
            fontWeight: FontWeight.w600,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: width / 16),
          filled: true,
          fillColor: Colors.grey[100], // Gray background color
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width / 15),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width / 15),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width / 15),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width / 15),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          hintText: hintString,
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 30),
            child: GestureDetector(
              onTap: () {
                onpress();
              },
              child: Icon(icon),
            ),
          ),
          suffixIconColor: ColorsManager.burble, // Active (focused) prefix icon color
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Data.';
          }
          return null;
        },
      ),
    );
  }
}












